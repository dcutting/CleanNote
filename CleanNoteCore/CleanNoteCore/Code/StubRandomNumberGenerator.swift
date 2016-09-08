import CleanNoteCore

class StubRandomNumberGenerator: RandomNumberGenerator {
  var spiedLimit: UInt32?

  func random(limit: UInt32) -> UInt32 {
    spiedLimit = limit
    return 0
  }
}
