import Foundation

public class RandomErrorGenerator: ErrorGenerator {
  let failureRate: UInt32

  public init(failOneIn: Int) {
    self.failureRate = UInt32(failOneIn)
  }

  public func hasError() -> Bool {
    guard failureRate > 0 else { return false }
    let random = arc4random_uniform(failureRate)
    return random == 0
  }
}
