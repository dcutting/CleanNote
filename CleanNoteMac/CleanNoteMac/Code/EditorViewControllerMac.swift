import Cocoa
import CleanNoteCore

class EditorViewControllerMac: NSViewController, EditorInterface {
  var interactor: EditorInteractorInput?
  @IBOutlet var textView: NSTextView!

  override func viewDidLoad() {
    configureTextInsets()
  }

  func configureTextInsets() {
    textView.textContainerInset = CGSize.init(width: 15, height: 15)
  }

  override func viewDidAppear() {
    interactor?.fetchText()
  }

  override func viewWillDisappear() {
    guard let text = textView.string else { return }
    interactor?.save(text: text)
  }

  func update(text: String) {
    textView.string = text
  }

  func error(text: String) {
    textView.string = "Error: \(text)"
  }
}
