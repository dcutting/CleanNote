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
}
