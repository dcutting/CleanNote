import Cocoa
import CleanNoteCore

protocol EditorViewControllerDelegate: class {
  func didModify(text: String)
  func didSaveText(for noteID: NoteID)
}

class EditorViewController: NSViewController {
  weak var delegate: EditorViewControllerDelegate?
  @IBOutlet weak var textContainerView: NSScrollView!
  @IBOutlet var textView: NSTextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextInsets()
  }

  private func configureTextInsets() {
    textView.textContainerInset = CGSize.init(width: 15, height: 15)
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

extension EditorViewController: EditorInterface {
  func update(text: String) {
    textView.isEditable = true
    textView.string = text
  }

  func show(error: NSError) {
    guard let window = view.window else {
      print("\(error)")
      return
    }
    presentError(error, modalFor: window, delegate: nil, didPresent: nil, contextInfo: nil)
  }

  func didSaveText(for noteID: NoteID) {
    delegate?.didSaveText(for: noteID)
  }
}

extension EditorViewController: NSTextViewDelegate {
  func textDidChange(_ obj: Notification) {
    guard let text = textView.string else { return }
    delegate?.didModify(text: text)
  }
}
