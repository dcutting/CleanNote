import Cocoa
import CleanNoteCore

protocol EditorViewControllerDelegate: class {
  func didModify(text: String)
}

class EditorViewController: NSViewController, EditorInterface, NSTextViewDelegate {

  @IBOutlet weak var textContainerView: NSScrollView!
  @IBOutlet var textView: NSTextView!

  weak var delegate: EditorViewControllerDelegate?

  override func viewDidLoad() {
    configureTextInsets()
  }

  private func configureTextInsets() {
    textView.textContainerInset = CGSize.init(width: 15, height: 15)
  }

  func update(text: String) {
    textView.isEditable = true
    textView.string = text
  }

  func show(error: String) {
    textView.isEditable = false
    textView.string = "Error: \(error)"
  }

  func textDidChange(_ obj: Notification) {
    guard let text = textView.string else { return }
    delegate?.didModify(text: text)
  }

  func showNoteScreen() {
    textContainerView.isHidden = false
  }

  func showNoNoteScreen() {
    textContainerView.isHidden = true
  }

  func prepareForEditing() {
    view.window?.makeFirstResponder(self.textView)
  }
}
