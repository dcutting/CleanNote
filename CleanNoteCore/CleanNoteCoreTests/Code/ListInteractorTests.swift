import XCTest
@testable import CleanNoteCore

class ListInteractorTests: XCTestCase {

  func test_fetchNotes_succeeds_passesNotesFromGatewayToOutput() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "another sample note")
    ]
    let list = List(notes: notes, selected: "1")

    let output = MockListInteractorOutput()
    output.expect(update: list)

    let gateway = InMemoryNoteGateway(notes: notes)

    let sut = ListInteractor(output: output, gateway: gateway)

    // Act.
    sut.fetchNotesAndSelect(noteID: "1")

    // Assert.
    XCTAssert(output.assert())
  }


  func test_fetchNotes_hasError_createsErrorForOutput() {
    // Arrange.
    let output = MockListInteractorOutput()
    let gateway = MockNoteGateway()
    gateway.stub(fetchNotesThrows: NoteGatewayError.unknown)
    let sut = ListInteractor(output: output, gateway: gateway)

    // Act.
    sut.fetchNotesAndSelect(noteID: "1")

    // Assert.
    guard let actualError = output.spiedDidFail else { XCTAssert(false); return }
    XCTAssertEqual(ListError.failToFetchNotes, actualError.code)
    //TODO: this doesn't yet test that the recovery closure calls the SUT again.
  }


  func test_makeNote_succeeds_passesNotesFromGatewayToOutput() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "just created note")
    ]
    let list = List(notes: notes, selected: "2")

    let output = MockListInteractorOutput()
    output.expect(update: list)

    let gateway = MockNoteGateway()
    let newNote = Note(id: "2", text: "just created note")
    gateway.stub(fetchNotes: notes)
    gateway.stub(makeNote: newNote)

    let sut = ListInteractor(output: output, gateway: gateway)

    // Act.
    sut.makeNote()

    // Assert.
    XCTAssert(output.assert())
  }


  func test_makeNote_hasError_createsErrorForOutput() {
    // Arrange.
    let output = MockListInteractorOutput()
    let gateway = MockNoteGateway()
    gateway.stub(makeNoteThrows: NoteGatewayError.unknown)
    let sut = ListInteractor(output: output, gateway: gateway)

    // Act.
    sut.makeNote()

    // Assert.
    guard let actualError = output.spiedDidFail else { XCTAssert(false); return }
    XCTAssertEqual(ListError.failToMakeNote, actualError.code)
    //TODO: this doesn't yet test that the recovery closure tries to make another note.
  }
}
