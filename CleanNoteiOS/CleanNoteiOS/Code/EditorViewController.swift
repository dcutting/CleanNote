import UIKit
import CleanNoteCore

class EditorViewController: UIViewController {
  var interactor: EditorInteractorInput!
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    interactor.fetchText()
    textView.becomeFirstResponder()
  }

  override func viewWillDisappear(_ animated: Bool) {
    interactor.save(text: textView.text)
  }
}

extension EditorViewController: EditorInterface {
  func update(text: String) {
    textView.text = text
  }

  func show(error: String) {
    let alert = makeAlert(with: error)
    show(alert: alert)
  }

  private func makeAlert(with text: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    return alert
  }

  private func show(alert: UIAlertController) {
    navigationController?.present(alert, animated: true)
  }

  func didSaveText(for noteID: NoteID) {
  }
}
