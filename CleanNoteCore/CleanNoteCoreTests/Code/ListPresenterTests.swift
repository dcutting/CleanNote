import XCTest
@testable import CleanNoteCore

class ListPresenterTests: XCTestCase {

  var interface: MockListInterface!
  var sut: ListPresenter!

  override func setUp() {
    interface = MockListInterface()
    sut = ListPresenter(interface: interface)
  }


  func test_update_notes_convertsToListViewNotes() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "another sample note")
    ]
    let list = List(notes: notes, selected: "1")

    // Act.
    sut.update(list: list)

    // Assert.
    let expectedNotes = [
      ListViewNote(id: "1", summary: "sample note"),
      ListViewNote(id: "2", summary: "another sample note")
    ]
    let expectedList = ListViewList(notes: expectedNotes, selected: "1")
    let actualList = interface.spiedUpdateList
    XCTAssert(areEqual(expectedList, actualList))
  }


  func test_update_notesWithoutText_insertsPlaceholderForSummary() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "")
    ]
    let list = List(notes: notes, selected: nil)

    // Act.
    sut.update(list: list)

    // Assert.
    let expectedNotes = [
      ListViewNote(id: "1", summary: "<empty>")
    ]
    let expectedList = ListViewList(notes: expectedNotes, selected: nil)
    let actualList = interface.spiedUpdateList
    XCTAssert(areEqual(expectedList, actualList))
  }


  func test_update_notesWithMultipleLines_joinsForSummary() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample\nnote")
    ]
    let list = List(notes: notes, selected: nil)

    // Act.
    sut.update(list: list)

    // Assert.
    let expectedNotes = [
      ListViewNote(id: "1", summary: "sample note")
    ]
    let expectedList = ListViewList(notes: expectedNotes, selected: nil)
    let actualList = interface.spiedUpdateList
    XCTAssert(areEqual(expectedList, actualList))
  }


  func test_didFail_passesErrorToInterface() {
    // Arrange.
    var didPassSameError = false
    let error = RetryableError(code: ListError.failToFetchNotes) {
      didPassSameError = true
    }

    // Act.
    sut.didFail(error: error)

    // Assert.
    guard let actualError = interface.spiedPresentError else { XCTAssert(false); return }
    let _ = actualError.attemptRecovery(optionIndex: 0)
    XCTAssert(didPassSameError)
  }


  func areEqual(_ expectedList: ListViewList, _ actualList: ListViewList?) -> Bool {
    guard let actualList = actualList else { return false }
    return expectedList == actualList
  }
}
