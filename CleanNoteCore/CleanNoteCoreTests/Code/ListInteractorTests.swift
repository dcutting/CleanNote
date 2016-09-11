import XCTest
@testable import CleanNoteCore

class ListInteractorTests: XCTestCase {

  func test_fetchNotes_passesNotesFromGatewayToOutput() {
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
}
