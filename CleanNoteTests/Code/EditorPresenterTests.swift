import XCTest
@testable import CleanNote

class EditorPresenterTests: XCTestCase {

  func test_didFetchText_updatesInterfaceWithText() {
    // Arrange.
    let interface = MockEditorInterface()
    
    let sut = EditorPresenter(interface: interface)

    // Act.
    sut.didFetch(text: "my note text")

    // Assert.
    let expectedText = "my note text"
    XCTAssertEqual(expectedText, interface.actualUpdateText)
  }
}
