import XCTest
@testable import CleanNote

class ListPresenterTests: XCTestCase {

  func test_didFetch_convertsNotesToListViewNotesForInterface() {
    // Arrange.
    let note1 = Note(id: "1", text: "sample note")
    let note2 = Note(id: "2", text: "another sample note")
    let notes = [note1, note2]

    let interface = MockListInterface()

    let sut = ListPresenter(interface: interface)

    // Act.
    sut.didFetch(notes: notes)

    // Assert.
    let listViewNote1 = ListViewNote(id: "1", summary: "sample note")
    let listViewNote2 = ListViewNote(id: "2", summary: "another sample note")
    let expectedNotes = [listViewNote1, listViewNote2]

    let actualNotes = interface.notes!

    XCTAssertEqual(expectedNotes, actualNotes)
  }
}
