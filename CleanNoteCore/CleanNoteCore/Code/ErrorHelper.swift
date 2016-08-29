import Foundation

func makeRetryableError(domain: String, code: Int, description: String, retry: @escaping (Void) -> Void) -> NSError {
  return makeError(domain: domain,
                   code: code,
                   description: description,
                   options: ["Try again", "Cancel"],
                   recovery: RecoveryAttempter(index: 0, handler: retry))
}

func makeError(domain: String, code: Int, description: String, options: [String], recovery: RecoveryAttempter) -> NSError {
  let userInfo: [String: Any] = [
    NSLocalizedDescriptionKey: description,
    NSLocalizedRecoveryOptionsErrorKey: options,
    NSRecoveryAttempterErrorKey: recovery
  ]
  return NSError(domain: domain, code: code, userInfo: userInfo)
}
