import XCTest
@testable import CleanNote

class ListInteractorTests: XCTestCase {

  func test_fetchNotes_passesNotesFromGatewayToOutput() {

    // Arrange.
    let note1 = Note(id: "1", text: "sample note")
    let note2 = Note(id: "2", text: "another sample note")
    let notes = [note1, note2]

    let output = MockListInteractorOutput()
    output.expect(didFetch: notes)

    let gateway = SampleNoteGateway(notes: notes)

    let sut = ListInteractor(output: output, gateway: gateway)

    // Act.
    sut.fetchNotes()

    // Assert.
    XCTAssert(output.assert())
  }
}
