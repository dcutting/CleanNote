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
}
