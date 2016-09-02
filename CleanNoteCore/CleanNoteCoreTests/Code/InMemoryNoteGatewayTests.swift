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
    sut.fetchNotes { result in
      let actualNotes = try! result()
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
    sut.fetchNote(with: "2") { result in
      do {
        let _ = try result()
      } catch {
        actualError = error as? NoteGatewayError
      }
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
    sut.fetchNote(with: "1") { result in
      let actualNote = try! result()
      XCTAssertEqual(expectedNote, actualNote)
    }
  }


  func test_makeNote_addsEmptyNoteToStore() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    var actualNote: Note?
    sut.makeNote() { result in
      actualNote = try! result()
    }

    // Assert.
    let expectedNote = Note(id: "NID:0", text: "")
    XCTAssertEqual(expectedNote, actualNote)
  }
  
  
  func test_makeNoteTwice_incrementsNoteID() {
    // Arrange.
    let sut = InMemoryNoteGateway(notes: [])

    // Act.
    sut.makeNote() { _ in }

    var actualNote: Note?
    sut.makeNote() { result in
      actualNote = try! result()
    }

    // Assert.
    let expectedNote = Note(id: "NID:1", text: "")
    XCTAssertEqual(expectedNote, actualNote)
  }
  
  
  func test_saveTextForID_noteFound_updatesNote() {
    // Arrange.
    let notes = [
      Note(id: "0", text: "sample note"),
      Note(id: "1", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act.
    sut.save(text: "new text", for: "1") { _ in }

    // Assert.
    sut.fetchNote(with: "1") { result in
      let actualNote = try! result()
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
    sut.save(text: "new text", for: "2") { result in
      do {
        try result()
      } catch {
        actualError = error as? NoteGatewayError
      }
    }

    // Assert.
    let expectedError = NoteGatewayError.notFound
    XCTAssertEqual(expectedError, actualError)
  }
}
