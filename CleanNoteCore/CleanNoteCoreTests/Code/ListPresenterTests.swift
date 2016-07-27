import XCTest
@testable import CleanNote

class ListPresenterTests: XCTestCase {

  var interface: MockListInterface!
  var sut: ListPresenter!

  override func setUp() {
    interface = MockListInterface()
    sut = ListPresenter(interface: interface)
  }


  func test_didFetch_notes_convertsToListViewNotes() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "another sample note")
    ]

    // Act.
    sut.didFetch(notes: notes)

    // Assert.
    let expectedNotes = [
      ListViewNote(id: "1", summary: "sample note"),
      ListViewNote(id: "2", summary: "another sample note")
    ]
    XCTAssert(areEqual(expectedNotes, interface.actualNotes))
  }


  func test_didFetch_notesWithoutText_insertsPlaceholderForSummary() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "")
    ]

    // Act.
    sut.didFetch(notes: notes)

    // Assert.
    let expectedNotes = [
      ListViewNote(id: "1", summary: "<empty>")
    ]
    XCTAssert(areEqual(expectedNotes, interface.actualNotes))
  }


  func test_didFetch_notesWithMultipleLines_joinsForSummary() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample\nnote")
    ]

    // Act.
    sut.didFetch(notes: notes)

    // Assert.
    let expectedNotes = [
      ListViewNote(id: "1", summary: "sample note")
    ]
    XCTAssert(areEqual(expectedNotes, interface.actualNotes))
  }


  func areEqual(_ expectedNotes: [ListViewNote], _ actualNotes: [ListViewNote]?) -> Bool {
    guard let actualNotes = actualNotes else { return false }
    return expectedNotes == actualNotes
  }
}
