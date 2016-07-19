import XCTest
@testable import CleanNote

class EditorPresenterTests: XCTestCase {

  func test_didFetchText_updatesInterfaceWithText() {
    // Arrange.
    let text = "my note text"

    let interface = MockEditorInterface()
    let sut = EditorPresenter(interface: interface)

    // Act.
    sut.didFetch(text: text)

    // Assert.
    let expectedText = text
    XCTAssertEqual(expectedText, interface.actualText)
  }
}
