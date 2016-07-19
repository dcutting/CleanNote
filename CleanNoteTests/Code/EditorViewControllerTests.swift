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


  func test_viewWillDisappear_savesText() {
    // Arrange.
    let textView = MockTextView()
    textView.text = "my edited text"

    let interactor = MockEditorInteractorInput()
    interactor.expectSave(text: "my edited text")

    let sut = EditorViewController()
    sut.textView = textView
    sut.interactor = interactor

    // Act.
    sut.viewWillDisappear(true)

    // Assert.
    XCTAssert(interactor.assert())
  }


  func test_updateText_setsTextView() {
    // Arrange.
    let textView = MockTextView()
    let interactor = MockEditorInteractorInput()

    let sut = EditorViewController()
    sut.textView = textView
    sut.interactor = interactor

    // Act.
    sut.update(text: "sample text")

    // Assert.
    let expectedText = "sample text"
    let actualText = textView.text
    XCTAssertEqual(expectedText, actualText)
  }
}
