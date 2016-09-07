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
    guard let actualCompletion = mockNoteGateway.spiedFetchNotes else { XCTAssert(false); return }
    actualCompletion { return [] }
    XCTAssertTrue(didPassCompletionBlockToDecoratedNoteGateway)
  }


  func test_fetchNoteWithID_hasError_throws() {
    // Arrange.
    stubErrorGenerator.stub(hasError: true)

    // Act.
    var actualError: NoteGatewayError?
    sut.fetchNote(with: "any ID") { result in
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
    sut.fetchNote(with: "dummy ID") { _ in
      didPassCompletionBlockToDecoratedNoteGateway = true
    }

    // Assert.
    guard let (actualNoteID, actualCompletion) = mockNoteGateway.spiedFetchNoteWithID else { XCTAssert(false); return }
    actualCompletion { return Note.null }
    let expectedNoteID = "dummy ID"
    XCTAssertEqual(expectedNoteID, actualNoteID)
    XCTAssertTrue(didPassCompletionBlockToDecoratedNoteGateway)
  }


  func test_makeNote_hasError_throws() {
    // Arrange.
    stubErrorGenerator.stub(hasError: true)

    // Act.
    var actualError: NoteGatewayError?
    sut.makeNote() { result in
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


  func test_makeNote_noError_delegatesToDecoratedGateway() {
    // Arrange.
    stubErrorGenerator.stub(hasError: false)

    // Act.
    var didPassCompletionBlockToDecoratedNoteGateway = false
    sut.makeNote() { _ in
      didPassCompletionBlockToDecoratedNoteGateway = true
    }

    // Assert.
    guard let actualCompletion = mockNoteGateway.spiedMakeNotes else { XCTAssert(false); return }
    actualCompletion { return Note.null }
    XCTAssertTrue(didPassCompletionBlockToDecoratedNoteGateway)
  }


  func test_saveTextForNoteID_hasError_throws() {
    // Arrange.
    stubErrorGenerator.stub(hasError: true)

    // Act.
    var actualError: NoteGatewayError?
    sut.save(text: "any text", for: "any ID") { result in
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


  func test_saveTextForNoteID_noError_delegatesToDecoratedGateway() {
    // Arrange.
    stubErrorGenerator.stub(hasError: false)

    // Act.
    var didPassCompletionBlockToDecoratedNoteGateway = false
    sut.save(text: "dummy text", for: "dummy ID") { _ in
      didPassCompletionBlockToDecoratedNoteGateway = true
    }

    // Assert.
    guard let (actualText, actualNoteID, actualCompletion) = mockNoteGateway.spiedSaveTextForNoteID else { XCTAssert(false); return }
    actualCompletion {}
    let expectedText = "dummy text"
    let expectedNoteID = "dummy ID"
    XCTAssertEqual(expectedText, actualText)
    XCTAssertEqual(expectedNoteID, actualNoteID)
    XCTAssertTrue(didPassCompletionBlockToDecoratedNoteGateway)
  }
}
