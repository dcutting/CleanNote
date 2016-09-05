import XCTest
@testable import CleanNoteCore

class RandomlyFailingNoteGatewayDecoratorTests: XCTestCase {

  var mockGateway: MockNoteGateway!
  var stubGenerator: StubErrorGenerator!
  var sut: RandomlyFailingNoteGatewayDecorator!

  override func setUp() {
    mockGateway = MockNoteGateway()
    stubGenerator = StubErrorGenerator()
    sut = RandomlyFailingNoteGatewayDecorator(noteGateway: mockGateway, errorGenerator: stubGenerator)
  }


  func test_fetchNotes_hasError_throws() {
    // Arrange.
    stubGenerator.stub(hasError: true)

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
    stubGenerator.stub(hasError: false)

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
