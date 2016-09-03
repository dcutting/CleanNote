import XCTest
@testable import CleanNoteCore

class RandomlyFailingNoteGatewayDecoratorTests: XCTestCase {

  func test_fetchNotes_hasError_throws() {
    // Arrange.
    let mockGateway = MockNoteGateway()
    let stubGenerator = StubErrorGenerator()
    stubGenerator.stub(hasError: true)
    let sut = RandomlyFailingNoteGatewayDecorator(noteGateway: mockGateway, errorGenerator: stubGenerator)

    // Act.
    var actualError: NoteGatewayError?
    sut.fetchNotes() { result in
      do {
        let _ = try result()
      } catch {
        actualError = error as? NoteGatewayError
      }
    }

    // Assert.
    let expectedError = NoteGatewayError.unknown
    XCTAssertEqual(expectedError, actualError)
  }


  func test_fetchNotes_noError_delegatesToDecoratedGateway() {
    // Arrange.
    let notes = [Note(id: "1", text: "sample note")]
    let stubGateway = InMemoryNoteGateway(notes: notes)
    let stubGenerator = StubErrorGenerator()
    stubGenerator.stub(hasError: false)
    let sut = RandomlyFailingNoteGatewayDecorator(noteGateway: stubGateway, errorGenerator: stubGenerator)

    // Act.
    var actualNotes: [Note]?
    sut.fetchNotes() { result in
      actualNotes = try! result()
    }

    // Assert.
    let expectedNotes = notes
    XCTAssertTrue(areEqual(expectedNotes, actualNotes))
  }

  func areEqual(_ expectedNotes: [Note], _ actualNotes: [Note]?) -> Bool {
    guard let actualNotes = actualNotes else { return false }
    return expectedNotes == actualNotes
  }
}
