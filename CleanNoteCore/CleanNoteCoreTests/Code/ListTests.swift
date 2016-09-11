import XCTest
@testable import CleanNoteCore

class ListTests: XCTestCase {

  func test_same_equal() {
    let notes1 = [
      Note(id: "myID", text: "some text"),
      Note(id: "yourID", text: "some other text")
    ]
    let selected1 = "yourID"
    let list1 = List(notes: notes1, selected: selected1)

    let notes2 = [
      Note(id: "myID", text: "some text"),
      Note(id: "yourID", text: "some other text")
    ]
    let selected2 = "yourID"
    let list2 = List(notes: notes2, selected: selected2)

    XCTAssertEqual(list1, list2)
  }


  func test_differentNotes_unequal() {
    let notes1 = [
      Note(id: "myID", text: "some text"),
    ]
    let selected1: NoteID? = "someID"
    let list1 = List(notes: notes1, selected: selected1)

    let notes2 = [
      Note(id: "anotherID", text: "completely different text"),
    ]
    let selected2: NoteID? = "someID"
    let list2 = List(notes: notes2, selected: selected2)

    XCTAssertNotEqual(list1, list2)
  }

  
  func test_differentSelection_unequal() {
    let notes1 = [
      Note(id: "myID", text: "some text"),
      Note(id: "yourID", text: "some other text")
    ]
    let selected1 = "myID"
    let list1 = List(notes: notes1, selected: selected1)

    let notes2 = [
      Note(id: "myID", text: "some text"),
      Note(id: "yourID", text: "some other text")
    ]
    let selected2 = "yourID"
    let list2 = List(notes: notes2, selected: selected2)

    XCTAssertNotEqual(list1, list2)
  }
}
