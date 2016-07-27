import UIKit

class MockTextView: UITextView {
  var shouldExpectBecomeFirstResponder = false
  var didCallBecomeFirstResponder = false

  func expectBecomeFirstResponder() {
    shouldExpectBecomeFirstResponder = true
  }

  func assert() -> Bool {
    if shouldExpectBecomeFirstResponder {
      return didCallBecomeFirstResponder
    }
    return true
  }

  override func becomeFirstResponder() -> Bool {
    didCallBecomeFirstResponder = true
    return true
  }
}
