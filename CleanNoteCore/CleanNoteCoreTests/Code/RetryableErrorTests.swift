import XCTest
@testable import CleanNoteCore

class DummyError: LocalizedError {
  let stubErrorDescription: String

  init(errorDescription: String) {
    stubErrorDescription = errorDescription
  }

  var errorDescription: String? {
    get { return stubErrorDescription }
  }
}

class RetryableErrorTests: XCTestCase {
  func test_errorDescription_readsFromWrappedError() {
    // Arrange.
    let wrappedError = DummyError(errorDescription: "wrapped error description")
    let sut = RetryableError(code: wrappedError) {}

    // Act.
    let actualErrorDescription = sut.errorDescription

    // Assert.
    let expectedErrorDescription = "wrapped error description"
    XCTAssertEqual(expectedErrorDescription, actualErrorDescription)
  }
}
