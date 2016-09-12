import XCTest
@testable import CleanNoteCore
@testable import CleanNoteiOS

class EditorViewControllerTests: XCTestCase {

  var textView: MockTextView!
  var interactor: MockEditorInteractorInput!
  var sut: EditorViewController!

  override func setUp() {
    textView = MockTextView()
    interactor = MockEditorInteractorInput(noteID: NoteID())

    sut = EditorViewController()
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
}
