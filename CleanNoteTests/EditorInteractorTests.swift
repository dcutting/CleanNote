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
  

  func test_fetchText_existingNote_verbatimText() {
    // Arrange.
    let output = MockEditorInteractorOutput()

    let note = Note(id: "one", text: "sample text")
    let gateway = SampleNoteGateway(notes: [note])

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "one")

    // Act.
    sut.fetchText()

    // Assert.
    let expectedText = "sample text"
    XCTAssertEqual(expectedText, output.actualText)
  }
}
