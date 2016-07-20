import XCTest
@testable import CleanNote

class ListViewControllerTests: XCTestCase {

  var interactor: MockListInteractorInput!
  var tableView: MockTableView!
  var sut: ListViewController!

  override func setUp() {
    interactor = MockListInteractorInput()
    tableView = MockTableView()

    tableView.stub(dequeueReusableCell: UITableViewCell(), with: "NoteCell")

    sut = ListViewController()
    sut.interactor = interactor
    sut.tableView = tableView
  }


  func test_viewWillAppear_fetchesNotes() {
    // Arrange.
    interactor.expectFetchNotes()

    // Act.
    sut.viewWillAppear(false)

    // Assert.
    XCTAssert(interactor.assert())
  }


  func test_update_displaysCorrectNumberOfRowsInTable() {
    // Arrange.
    let notes = [
      ListViewNote(id: "1", summary: "sample note"),
      ListViewNote(id: "2", summary: "another sample note")
    ]

    // Act.
    sut.update(notes: notes)

    // Assert.
    let expectedRows = 2
    let actualRows = sut.tableView(tableView, numberOfRowsInSection: 0)
    XCTAssertEqual(expectedRows, actualRows)
  }


  func test_update_displaysCorrectDataInTable() {
    // Arrange.
    let notes = [
      ListViewNote(id: "1", summary: "sample note"),
      ListViewNote(id: "2", summary: "another sample note")
    ]

    // Act.
    sut.update(notes: notes)

    // Assert.
    for row in (0..<notes.count) {
      let indexPath = IndexPath(row: row, section: 0)
      let cell = sut.tableView(tableView, cellForRowAt: indexPath)
      let expectedCellText = notes[row].summary
      let actualCellText = cell.textLabel?.text
      XCTAssertEqual(expectedCellText, actualCellText)
    }
  }
}
