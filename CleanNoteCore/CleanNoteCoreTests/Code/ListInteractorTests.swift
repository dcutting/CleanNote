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
}
