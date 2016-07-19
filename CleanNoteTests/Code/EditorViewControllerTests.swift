import XCTest
@testable import CleanNote

class EditorViewControllerTests: XCTestCase {

  func test_viewDidLoad_tellsInteractorToFetchText() {
    // Arrange.
    let textView = MockTextView()
    let interactor = MockEditorInteractorInput()
    interactor.expectFetchText()

    let sut = EditorViewController()
    sut.textView = textView
    sut.interactor = interactor

    // Act.
    sut.viewDidLoad()

    // Assert.
    XCTAssert(interactor.assert())
  }


  func test_viewDidLoad_showsKeyboard() {
    // Arrange.
    let interactor = MockEditorInteractorInput()
    let textView = MockTextView()
    textView.expectBecomeFirstResponder()

    let sut = EditorViewController()
    sut.textView = textView
    sut.interactor = interactor

    // Act.
    sut.viewDidLoad()

    // Assert.
    XCTAssert(textView.assert())
  }
}
