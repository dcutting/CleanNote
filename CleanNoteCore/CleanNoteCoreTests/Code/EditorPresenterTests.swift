import XCTest
@testable import CleanNoteCore

class EditorPresenterTests: XCTestCase {

  var interface: MockEditorInterface!
  var sut: EditorPresenter!

  override func setUp() {
    interface = MockEditorInterface()
    sut = EditorPresenter(interface: interface)
  }


  func test_updateText_updatesInterfaceWithText() {
    // Act.
    sut.update(text: "my note text")

    // Assert.
    let expectedText = "my note text"
    XCTAssertEqual(expectedText, interface.spiedUpdateText)
  }


  func test_didFailToSave_showsError() {
    // Arrange.
    var didPassSameError = false
    let error = RetryableError(code: EditorError.failToSaveNote) {
      didPassSameError = true
    }

    // Act.
    sut.didFail(error: error)

    // Assert.
    guard let actualError = interface.spiedPresentError else { XCTAssert(false); return }
    let _ = actualError.attemptRecovery(optionIndex: 0)
    XCTAssert(didPassSameError)
  }
}
