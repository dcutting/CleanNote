import Foundation

public struct RetryableError<T: LocalizedError>: LocalizedError, RecoverableError {
  public let code: T
  let recovery: (Void) -> Void

  public var errorDescription: String? {
    return code.errorDescription
  }

  public var recoveryOptions: [String] {
    get { return ["Try again", "Cancel"] }
  }

  public func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {
    guard 0 == recoveryOptionIndex else { return false }
    recovery()
    return true
  }
}
