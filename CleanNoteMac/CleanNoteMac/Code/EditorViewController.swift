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
  @IBOutlet var errorTextField: NSTextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextInsets()
  }

  private func configureTextInsets() {
    textView.textContainerInset = CGSize.init(width: 15, height: 15)
  }

  func showNote() {
    textContainerView.isHidden = false
  }

  func showNoNoteSelected() {
    show(text: "No note selected")
  }

  fileprivate func show(text: String) {
    errorTextField.stringValue = text
    textContainerView.isHidden = true
  }

  func prepareForEditing() {
    view.window?.makeFirstResponder(self.textView)
  }
}

extension EditorViewController: EditorInterface {
  func update(text: String) {
    textView.string = text
  }

  func present(error: EditorError) {
    switch error {
    case .failToFetchNote:
      show(text: error.localizedDescription)
    case .failToSaveNote:
      guard let window = view.window else { return }
      presentError(error, modalFor: window, delegate: nil, didPresent: nil, contextInfo: nil)
    }
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
