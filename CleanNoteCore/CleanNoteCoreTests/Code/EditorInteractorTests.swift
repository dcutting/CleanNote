import XCTest
@testable import CleanNoteCore

class EditorInteractorTests: XCTestCase {

  var output: MockEditorInteractorOutput!

  override func setUp() {
    output = MockEditorInteractorOutput()
  }


  func test_fetchText_existingNote_verbatimText() {
    // Arrange.
    let note = Note(id: "one", text: "sample text")
    let gateway = InMemoryNoteGateway(notes: [note])

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "one")

    // Act.
    sut.fetchText()

    // Assert.
    let expectedText = "sample text"
    let actualText = output.spiedUpdateText
    XCTAssertEqual(expectedText, actualText)
  }


  func test_fetchText_noteNotFound_failsToFetch_informsOutput() {
    // Arrange.
    let gateway = MockNoteGateway()
    gateway.stub(fetchNoteWithIDThrows: NoteGatewayError.unknown)

    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "any")

    // Act.
    sut.fetchText()

    // Assert.
    guard let actualError = output.spiedDidFail else { XCTAssert(false); return }
    XCTAssertEqual(EditorError.failToFetchNote, actualError.code)
  }


  func test_saveText_savesToGateway() {
    // Arrange.
    let gateway = MockNoteGateway()
    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "one")

    // Act.
    sut.save(text: "any text")

    // Assert.
    guard let (actualText, actualNoteID, _) = gateway.spiedSaveTextForNoteID else { XCTAssert(false); return }
    let expectedText = "any text"
    XCTAssertEqual(expectedText, actualText)
    let expectedNoteID = "one"
    XCTAssertEqual(expectedNoteID, actualNoteID)
  }


//  func test_saveText_existingNote_failsToSave_informsOutput() {
//    // Arrange.
//    let gateway = MockNoteGateway()
//    gateway.stub(saveThrows: .notFound)
//    output.expectDidFailToSaveText()
//
//    let sut = EditorInteractor(output: output, gateway: gateway, noteID: "one")
//
//    // Act.
//    sut.save(text: "my note text")
//
//    // Assert.
//    XCTAssertTrue(output.assert())
//  }
}
