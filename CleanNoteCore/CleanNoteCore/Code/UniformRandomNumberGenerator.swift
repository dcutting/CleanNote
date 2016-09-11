import Foundation

public class UniformRandomNumberGenerator: RandomNumberGenerator {
  public init() {
  }

  public func random(limit: UInt32) -> UInt32 {
    return arc4random_uniform(limit)
  }
}
