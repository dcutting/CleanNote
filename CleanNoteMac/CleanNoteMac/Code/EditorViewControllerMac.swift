import Cocoa
import CleanNoteCore

class EditorViewControllerMac: NSViewController, EditorInterface {
  var interactor: EditorInteractorInput!
  var count: Int = 0
  @IBOutlet var textView: NSTextView!

  override func awakeFromNib() {
    print("awaking editor")
  }

  override func viewDidAppear() {
    count += 1
    print("appearing \(count)")
  }

  func fetchText() {
    interactor.fetchText()
  }

  func update(text: String) {
    textView.string = text
  }

  func error(text: String) {
    textView.string = "Error: \(text)"
  }
}
