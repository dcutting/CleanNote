import XCTest
@testable import CleanNote

class ListViewControllerTests: XCTestCase {

  var interactor: MockListInteractorInput!
  var sut: ListViewController!

  override func setUp() {
    interactor = MockListInteractorInput()

    sut = ListViewController()
    sut.interactor = interactor
  }

  func test_viewWillAppear_fetchesNotes() {
    // Arrange.
    interactor.expectFetchNotes()

    // Act.
    sut.viewWillAppear(false)

    // Assert.
    XCTAssert(interactor.assert())
  }
}
