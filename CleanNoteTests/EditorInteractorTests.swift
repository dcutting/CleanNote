import XCTest
@testable import CleanNote

class EditorInteractorTests: XCTestCase {

  var output: MockEditorInteractorOutput!

  override func setUp() {
    output = MockEditorInteractorOutput()
  }


  func test_fetchText_newNote_emptyText() {
    // Arrange.
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
    let note = Note(id: "one", text: "sample text")
    let gateway = SampleNoteGateway(notes: [note])

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "one")

    // Act.
    sut.fetchText()

    // Assert.
    let expectedText = "sample text"
    XCTAssertEqual(expectedText, output.actualText)
  }


  func test_fetchText_noteNotFound_emptyText() {
    // Arrange.
    let note = Note(id: "one", text: "sample text")
    let gateway = SampleNoteGateway(notes: [note])

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "zilch")

    // Act.
    sut.fetchText()

    // Assert.
    let expectedText = ""
    XCTAssertEqual(expectedText, output.actualText)
  }


  func test_saveText_newNote_createsNote() {
    // Arrange.
    let gateway = MockNoteGateway()

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: nil)

    // Act.
    sut.save(text: "my note text")

    // Assert.
    let expectedText = "my note text"
    let actualText = gateway.textForCreateNote
    XCTAssertEqual(expectedText, actualText)
  }
}
