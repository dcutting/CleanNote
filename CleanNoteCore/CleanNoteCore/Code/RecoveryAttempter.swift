import Foundation

class RecoveryAttempter: NSObject {
  let index: Int
  let handler: (Void) -> Void

  init(index: Int, handler: @escaping (Void) -> Void) {
    self.index = index
    self.handler = handler
  }

  override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int, delegate: Any?, didRecoverSelector: Selector?, contextInfo: UnsafeMutableRawPointer?) {
    guard recoveryOptionIndex == index else { return }
    handler()
  }
}
