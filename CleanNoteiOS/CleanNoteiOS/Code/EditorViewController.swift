import UIKit
import CleanNoteCore

class EditorViewController: UIViewController {
  var interactor: EditorInteractorInput!
  lazy var alertHelper: AlertHelper = {
    return AlertHelper()
  }()
    
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    textView.becomeFirstResponder()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchText()
    }
    
}

extension EditorViewController: EditorInterface {
  func update(text: String) {
    textView.text = text
  }

  func present(error: RetryableError<EditorError>) {
    guard let controller = navigationController else { return }
    if EditorError.failToFetchNote == error.code {
      controller.popViewController(animated: true)
    }
    alertHelper.show(title: "Error", text: error.localizedDescription, controller: controller)
  }

  func didSaveText(for noteID: NoteID) {
  }
}

extension EditorViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    interactor.save(text: textView.text)
  }
}
