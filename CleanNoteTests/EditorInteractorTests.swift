import XCTest
@testable import CleanNote

class EditorInteractorTests: XCTestCase {

  func test_fetchText_newNote_emptyText() {
    // Arrange.
    let output = MockEditorInteractorOutput()
    let gateway = SampleNoteGateway(notes: [])

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: nil)

    // Act.
    sut.fetchText()

    // Assert.
    let expectedText = ""
    XCTAssertEqual(expectedText, output.actualText)
  }
}
