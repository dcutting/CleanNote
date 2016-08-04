import XCTest
@testable import CleanNoteCore

class InMemoryNoteGatewayTests: XCTestCase {

  func test_fetchNotes_returnsAllNotes() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act and assert.
    let expectedNotes = notes
    sut.fetchNotes { actualNotes in
      XCTAssertEqual(expectedNotes, actualNotes)
    }
  }


  func test_fetchNoteWithID_noteNotFound_throwsError() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    var actualError: NoteGatewayError?
    do {
      try sut.fetchNote(with: "2") { _ in }
    } catch {
      actualError = error as? NoteGatewayError
    }

    // Assert.
    let expectedError = NoteGatewayError.notFound
    XCTAssertEqual(expectedError, actualError)
  }


  func test_fetchNoteWithID_noteFound_returnsNote() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act and assert.
    let expectedNote = notes[1]
    try! sut.fetchNote(with: "1") { actualNote in
      XCTAssertEqual(expectedNote, actualNote)
    }
  }


  func test_createNote_addsEmptyNoteToStore() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    let actualNoteID = try! sut.createNote()

    // Assert.
    try! sut.fetchNote(with: actualNoteID) { actualNote in
      let expectedNote = Note(id: actualNoteID, text: "")
      XCTAssertEqual(expectedNote, actualNote)
    }
  }


  func test_saveTextForID_noteFound_updatesNote() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    try! sut.save(text: "new text", for: "1")

    // Assert.
    try! sut.fetchNote(with: "1") { actualNote in
      let expectedNote = Note(id: "1", text: "new text")
      XCTAssertEqual(expectedNote, actualNote)
    }
  }


  func test_saveTextForID_noteNotFound_throwsError() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    var actualError: NoteGatewayError?
    do {
      try sut.save(text: "new text", for: "2")
    } catch {
      actualError = error as? NoteGatewayError
    }

    // Assert.
    let expectedError = NoteGatewayError.notFound
    XCTAssertEqual(expectedError, actualError)
  }
}
