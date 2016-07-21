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
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "another sample note")
    ]

    let sut = InMemoryNoteGateway(notes: notes)

    // Act and assert.
    sut.fetchNote(with: "3") { actualNote in
      XCTAssertNil(actualNote)
    }
  }
}
