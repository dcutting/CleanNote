import XCTest
@testable import CleanNoteCore

class NoteTests: XCTestCase {

  func test_same_equal() {
    let note1 = Note(id: "myID", text: "some text")
    let note2 = Note(id: "myID", text: "some text")

    XCTAssertEqual(note1, note2)
  }

  func test_differentIDs_unequal() {
    let note1 = Note(id: "myID", text: "some text")
    let note2 = Note(id: "yourID", text: "some text")

    XCTAssertNotEqual(note1, note2)
  }

  func test_differentText_unequal() {
    let note1 = Note(id: "myID", text: "some text")
    let note2 = Note(id: "myID", text: "not some text")

    XCTAssertNotEqual(note1, note2)
  }

  func test_nullNote() {
    let actualNote = Note.null

    let expectedNote = Note(id: "", text: "")
    XCTAssertEqual(expectedNote, actualNote)
  }
}
