import XCTest
@testable import CleanNote

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


  func test_fetchNoteWithID_noteNotFound_returnsNil() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act and assert.
    sut.fetchNote(with: "2") { actualNote in
      XCTAssertNil(actualNote)
    }
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
    sut.fetchNote(with: "1") { actualNote in
      XCTAssertEqual(expectedNote, actualNote)
    }
  }


  func test_createNote_addsNoteToStore() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    let actualNoteID = sut.createNote(with: "more text")

    // Assert.
    sut.fetchNote(with: actualNoteID) { actualNote in
      let expectedNote = Note(id: actualNoteID, text: "more text")
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
    sut.fetchNote(with: "1") { actualNote in
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
