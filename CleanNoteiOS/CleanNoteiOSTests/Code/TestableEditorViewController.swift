import UIKit
@testable import CleanNote

class TestableEditorViewController: EditorViewController {
  var spiedAlertController: UIAlertController?

  override func show(alert: UIAlertController) {
    spiedAlertController = alert
    super.show(alert: alert)
  }
}
