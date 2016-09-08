import CleanNoteCore

class StubRandomNumberGenerator: RandomNumberGenerator {
  var spiedLimit: UInt32?
  var stubbedRandom: UInt32 = 0

  func random(limit: UInt32) -> UInt32 {
    spiedLimit = limit
    return stubbedRandom
  }

  func stubRandom(returns: UInt32) {
    stubbedRandom = returns
  }
}
