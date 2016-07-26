import UIKit

class EditorViewController: UIViewController, EditorInterface {
  var interactor: EditorInteractorInput!
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    interactor.fetchText()
    textView.becomeFirstResponder()
  }

  override func viewWillDisappear(_ animated: Bool) {
    interactor.save(text: textView.text)
  }

  func update(text: String) {
    textView.text = text
  }

  func error(text: String) {
    let alert = makeAlert(with: text)
    self.navigationController?.present(alert, animated: true)
  }

  func makeAlert(with text: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    return alert
  }
}
