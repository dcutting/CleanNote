import XCTest
@testable import CleanNote

class EditorViewControllerTests: XCTestCase {

  func test_viewDidLoad_tellsInteractorToFetchText() {
    // Arrange.
    let interactor = MockEditorInteractorInput()
    interactor.expectFetchText()

    let sut = EditorViewController()
    sut.textView = UITextView()
    sut.interactor = interactor

    // Act.
    sut.viewDidLoad()

    // Assert.
    XCTAssert(interactor.assert())
  }
}
