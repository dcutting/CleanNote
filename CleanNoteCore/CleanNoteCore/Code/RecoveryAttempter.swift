import Foundation

class RecoveryAttempter: NSObject {
  let index: Int
  let handler: (Void) -> Void

  init(index: Int, handler: (Void) -> Void) {
    self.index = index
    self.handler = handler
  }

  override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int, delegate: AnyObject?, didRecoverSelector: Selector?, contextInfo: UnsafeMutablePointer<Void>?) {
    guard recoveryOptionIndex == index else { return }
    handler()
  }
}
