import Foundation

func makeError(domain: String, code: Int, description: String, suggestion: String, options: [String], recovery: RecoveryAttempter) -> NSError {
  let userInfo: [String: Any] = [
    NSLocalizedDescriptionKey: description,
    NSLocalizedRecoverySuggestionErrorKey: suggestion,
    NSLocalizedRecoveryOptionsErrorKey: options,
    NSRecoveryAttempterErrorKey: recovery
  ]
  return NSError(domain: domain, code: code, userInfo: userInfo)
}
