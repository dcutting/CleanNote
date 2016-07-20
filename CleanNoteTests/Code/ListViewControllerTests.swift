import XCTest
@testable import CleanNote

class ListViewControllerTests: XCTestCase {

  var interactor: MockListInteractorInput!
  var tableView: UITableView!
  var sut: ListViewController!

  override func setUp() {
    interactor = MockListInteractorInput()
    tableView = UITableView()

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
}
