import UIKit

class AlertHelper {
  func show(title: String, text: String, controller: UIViewController) {
    let alert = makeAlert(title: title, text: text)
    present(alert: alert, controller: controller)
  }

  private func makeAlert(title: String, text: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    return alert
  }

  private func present(alert: UIAlertController, controller: UIViewController) {
    controller.present(alert, animated: true)
  }
}
