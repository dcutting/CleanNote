import Cocoa
import CleanNoteCore

class NotesViewController: NSSplitViewController, ListViewControllerMacDelegate, EditorViewControllerMacDelegate {

  var listViewController: ListViewControllerMac!
  var editorViewController: EditorViewControllerMac!

  var listInteractor: ListInteractorInput?
  var editorInteractor: EditorInteractorInput?

  var listWireframe: ListWireframeMac?
  var editorWireframe: EditorWireframeMac?

  override func viewDidLoad() {
    configureAppearance()
    configureChildren()
    configureDelegates()
    super.viewDidLoad()
  }
  
  func configureAppearance() {
    view.wantsLayer = true   // To enable round window corners.
  }

  func configureChildren() {
    listViewController = childViewControllers[0] as! ListViewControllerMac
    editorViewController = childViewControllers[1] as! EditorViewControllerMac
  }

  func configureDelegates() {
    listViewController.delegate = self
    editorViewController.delegate = self
  }

  func start() {
    configureList()
    listInteractor?.fetchNotes()
  }

  func configureList() {
    listInteractor = listWireframe?.configure(listViewController: listViewController)
  }

  func didSelect(noteID: NoteID) {
    configureEditor(noteID: noteID)
    editorInteractor?.fetchText()
//    listInteractor?.fetchNotes()
  }

  func configureEditor(noteID: NoteID) {
    editorInteractor = editorWireframe?.configure(editorViewController: editorViewController, noteID: noteID)
  }

  func didDeselectAllNotes() {
    editorInteractor = nil
    listInteractor?.fetchNotes()
  }

  func didModify(text: String) {
    editorInteractor?.save(text: text)
  }
}
