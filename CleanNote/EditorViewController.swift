import UIKit

class EditorViewController: UIViewController, EditorInterface {
  var interactor: EditorInteractor!
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    interactor.fetchText()
  }

  override func viewWillDisappear(_ animated: Bool) {
    interactor.save(text: textView.text)
  }

  func update(text: String) {
    textView.text = text
  }
}
