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
    configureChildrenControllers()
    super.viewDidLoad()
  }
  
  func configureAppearance() {
    view.wantsLayer = true   // To enable round window corners.
  }

  func configureChildrenControllers() {
    listViewController = childViewControllers[0] as! ListViewControllerMac
    editorViewController = childViewControllers[1] as! EditorViewControllerMac

    listViewController.delegate = self
    editorViewController.delegate = self
  }

  func start() {
    configureList()
    editorViewController.showNoNoteScreen()
    listInteractor?.fetchNotes()
  }

  func configureList() {
    listInteractor = listWireframe?.configure(listViewController: listViewController)
  }

  func didSelect(noteID: NoteID) {
    configureEditor(noteID: noteID)
    editorViewController.showNoteScreen()
    editorInteractor?.fetchText()
  }

  func configureEditor(noteID: NoteID) {
    editorInteractor = editorWireframe?.configure(editorViewController: editorViewController, noteID: noteID)
  }

  func didDeselectAllNotes() {
    editorInteractor = nil
    editorViewController.showNoNoteScreen()
  }

  func didModify(text: String) {
    editorInteractor?.save(text: text)
    if let noteID = editorInteractor?.noteID {
      listInteractor?.fetch(noteID: noteID)
    }
  }

  @IBAction func newNote(_ sender: AnyObject) {
    // TODO: create a new note
//    configureEditor(noteID: nil)
//    editorViewController.showNoteScreen()
//    editorInteractor?.save(text: text)
//    editorInteractor?.fetchText()
  }
}
