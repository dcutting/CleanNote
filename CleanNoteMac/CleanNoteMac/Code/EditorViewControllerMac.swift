import Cocoa
import CleanNoteCore

protocol EditorViewControllerMacDelegate: class {
  func didModify(text: String)
}

class EditorViewControllerMac: NSViewController, EditorInterface, NSTextViewDelegate {

  @IBOutlet weak var textContainerView: NSScrollView!
  @IBOutlet var textView: NSTextView!

  weak var delegate: EditorViewControllerMacDelegate?

  override func viewDidLoad() {
    configureTextInsets()
  }

  func configureTextInsets() {
    textView.textContainerInset = CGSize.init(width: 15, height: 15)
  }

  func update(text: String) {
    textView.isEditable = true
    textView.string = text
  }

  func error(text: String) {
    textView.isEditable = false
    textView.string = "Error: \(text)"
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
}

