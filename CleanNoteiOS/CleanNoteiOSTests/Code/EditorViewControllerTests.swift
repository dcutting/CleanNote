import XCTest
@testable import CleanNoteCore
@testable import CleanNoteiOS

class EditorViewControllerTests: XCTestCase {

  var textView: MockTextView!
  var interactor: MockEditorInteractorInput!
  var sut: TestableEditorViewController!

  override func setUp() {
    textView = MockTextView()
    interactor = MockEditorInteractorInput()

    sut = TestableEditorViewController()
    sut.textView = textView
    sut.interactor = interactor
  }


  func test_viewDidLoad_tellsInteractorToFetchText() {
    // Arrange.
    interactor.expectFetchText()

    // Act.
    sut.viewDidLoad()

    // Assert.
    XCTAssert(interactor.assert())
  }


  func test_viewDidLoad_showsKeyboard() {
    // Arrange.
    textView.expectBecomeFirstResponder()

    // Act.
    sut.viewDidLoad()

    // Assert.
    XCTAssert(textView.assert())
  }


  func test_viewWillDisappear_savesText() {
    // Arrange.
    textView.text = "my edited text"
    interactor.expect(save: "my edited text")

    // Act.
    sut.viewWillDisappear(false)

    // Assert.
    XCTAssert(interactor.assert())
  }


  func test_updateText_setsTextView() {
    // Act.
    sut.update(text: "sample text")

    // Assert.
    let expectedText = "sample text"
    let actualText = textView.text
    XCTAssertEqual(expectedText, actualText)
  }


  func test_errorText_presentsAlert() {
    // Act.
    sut.error(text: "sample error")

    // Assert.
    let expectedText = "sample error"
    let actualText = sut.spiedAlertController?.message
    XCTAssertEqual(expectedText, actualText)
  }
}
