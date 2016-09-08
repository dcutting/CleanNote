import XCTest
@testable import CleanNoteCore

class RandomErrorGeneratorTests: XCTestCase {

  func test_hasOneErrorIn10_RNGlimitIsSetTo10() {
    // Arrange.
    let stubRNG = StubRandomNumberGenerator()
    let sut = RandomErrorGenerator(failOneIn: 10, randomNumberGenerator: stubRNG)

    // Act.
    let _ = sut.hasError()

    // Assert.
    let actualLimit = stubRNG.spiedLimit
    let expectedLimit = UInt32(10)
    XCTAssertEqual(expectedLimit, actualLimit)
  }
}
