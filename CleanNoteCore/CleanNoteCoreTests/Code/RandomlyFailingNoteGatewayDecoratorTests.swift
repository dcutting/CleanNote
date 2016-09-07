import XCTest
@testable import CleanNoteCore

class RandomlyFailingNoteGatewayDecoratorTests: XCTestCase {

  var mockNoteGateway: MockNoteGateway!
  var stubErrorGenerator: StubErrorGenerator!
  var sut: RandomlyFailingNoteGatewayDecorator!

  override func setUp() {
    mockNoteGateway = MockNoteGateway()
    stubErrorGenerator = StubErrorGenerator()
    sut = RandomlyFailingNoteGatewayDecorator(noteGateway: mockNoteGateway, errorGenerator: stubErrorGenerator)
  }


  func test_fetchNotes_hasError_throws() {
    // Arrange.
    stubErrorGenerator.stub(hasError: true)

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
    stubErrorGenerator.stub(hasError: false)

    // Act.
    var didPassCompletionBlockToDecoratedNoteGateway = false
    sut.fetchNotes() { _ in
      didPassCompletionBlockToDecoratedNoteGateway = true
    }

    // Assert.
    let actualCompletion = mockNoteGateway.spiedFetchNotes!
    actualCompletion { return [] }
    XCTAssertTrue(didPassCompletionBlockToDecoratedNoteGateway)
  }


  func test_fetchNoteWithID_hasError_throws() {
    // Arrange.
    stubErrorGenerator.stub(hasError: true)

    // Act.
    var actualError: NoteGatewayError?
    sut.fetchNote(with: "anyID") { result in
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
  

  func test_fetchNoteWithID_noError_delegatesToDecoratedGateway() {
    // Arrange.
    stubErrorGenerator.stub(hasError: false)

    // Act.
    var didPassCompletionBlockToDecoratedNoteGateway = false
    sut.fetchNote(with: "1") { _ in
      didPassCompletionBlockToDecoratedNoteGateway = true
    }

    // Assert.
    let (actualNoteID, actualCompletion) = mockNoteGateway.spiedFetchNoteWithID!
    actualCompletion { return Note.null }
    let expectedNoteID = "1"
    XCTAssertEqual(expectedNoteID, actualNoteID)
    XCTAssertTrue(didPassCompletionBlockToDecoratedNoteGateway)
  }
}
