import XCTest
@testable import CleanNote

class ListInteractorTests: XCTestCase {

  func test_fetchNotes_passesNotesFromGatewayToOutput() {
    // Arrange.
    let notes = [
      Note(id: "1", text: "sample note"),
      Note(id: "2", text: "another sample note")
    ]

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
