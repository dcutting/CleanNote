import UIKit

class EditorViewController: UIViewController, EditorInterface {
  var interactor: EditorInteractor!
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    interactor.prepareNote()
  }

  func update(note: EditorViewNote) {
    textView.text = note.text
  }
}
