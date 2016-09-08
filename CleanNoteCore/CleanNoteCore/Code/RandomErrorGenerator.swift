public protocol RandomNumberGenerator {
  func random(limit: UInt32) -> UInt32
}

public class RandomErrorGenerator: ErrorGenerator {
  let failureRate: UInt32
  let randomNumberGenerator: RandomNumberGenerator

  public init(failOneIn: UInt32, randomNumberGenerator: RandomNumberGenerator) {
    self.failureRate = failOneIn
    self.randomNumberGenerator = randomNumberGenerator
  }

  public func hasError() -> Bool {
    guard failureRate > 0 else { return false }
    let random = randomNumberGenerator.random(limit: failureRate)
    return random == 0
  }
}
