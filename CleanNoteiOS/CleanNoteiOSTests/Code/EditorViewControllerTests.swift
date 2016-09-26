import XCTest
@testable import CleanNoteCore
@testable import CleanNoteiOS

class EditorViewControllerTests: XCTestCase {

  var textView: MockTextView!
  var interactor: MockEditorInteractorInput!
  var sut: TestableEditorViewController!

  override func setUp() {
    textView = MockTextView()
    interactor = MockEditorInteractorInput(noteID: NoteID())

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


  func test_updateText_setsTextView() {
    // Act.
    sut.update(text: "sample text")

    // Assert.
    let expectedText = "sample text"
    let actualText = textView.text
    XCTAssertEqual(expectedText, actualText)
  }


  func test_presentError_presentsAlert() {
    // Act.
    let error = RetryableError(code: EditorError.failToSaveNote) {}
    sut.present(error: error)
    
    // Assert.
    let expectedText = error.localizedDescription
    let actualText = sut.alertHelperSpy.spiedText
    XCTAssertEqual(expectedText, actualText)
  }
}
