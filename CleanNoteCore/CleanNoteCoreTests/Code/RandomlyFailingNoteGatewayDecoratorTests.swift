import XCTest
@testable import CleanNoteCore

class RandomlyFailingNoteGatewayDecoratorTests: XCTestCase {

  var stubGenerator: StubErrorGenerator!


  override func setUp() {
    stubGenerator = StubErrorGenerator()
  }


  func test_fetchNotes_hasError_throws() {
    // Arrange.
    stubGenerator.stub(hasError: true)
    let sut = RandomlyFailingNoteGatewayDecorator(noteGateway: MockNoteGateway(), errorGenerator: stubGenerator)

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
    let mockGateway = MockNoteGateway()
    stubGenerator.stub(hasError: false)
    let sut = RandomlyFailingNoteGatewayDecorator(noteGateway: mockGateway, errorGenerator: stubGenerator)

    // Act.
    var didCallDecoratedNoteGateway = false
    sut.fetchNotes() { _ in
      didCallDecoratedNoteGateway = true
    }

    // Assert.
    let actualCompletion = mockGateway.completionForFetchNotes!
    actualCompletion { return [] }
    XCTAssertTrue(didCallDecoratedNoteGateway)
  }
}
