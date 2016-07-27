import XCTest
@testable import CleanNoteCore

class EditorPresenterTests: XCTestCase {

  var interface: MockEditorInterface!
  var sut: EditorPresenter!

  override func setUp() {
    interface = MockEditorInterface()
    sut = EditorPresenter(interface: interface)
  }


  func test_didFetchText_updatesInterfaceWithText() {
    // Act.
    sut.didFetch(text: "my note text")

    // Assert.
    let expectedText = "my note text"
    XCTAssertEqual(expectedText, interface.actualUpdateText)
  }


  func test_didFailToSave_showsError() {
    // Arrange.
    interface.expectError()

    // Act.
    sut.didFailToSave()

    // Assert.
    XCTAssertTrue(interface.assert())
  }
}
