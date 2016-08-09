import Cocoa
import CleanNoteCore

class NotesViewController: NSSplitViewController, ListViewControllerDelegate, EditorViewControllerDelegate {

  var listWireframe: ListWireframe!
  var editorWireframe: EditorWireframe!

  var listViewController: ListViewController!
  var editorViewController: EditorViewController!

  var listInteractor: ListInteractorInput?
  var editorInteractor: EditorInteractorInput?

  override func viewDidLoad() {
    configureAppearance()
    configureChildrenControllers()
    super.viewDidLoad()
  }
  
  private func configureAppearance() {
    view.wantsLayer = true   // To enable round window corners.
  }

  private func configureChildrenControllers() {
    listViewController = childViewControllers[0] as! ListViewController
    editorViewController = childViewControllers[1] as! EditorViewController

    listViewController.delegate = self
    editorViewController.delegate = self
  }

  func start() {
    configureList()
    editorViewController.showNoNoteScreen()
    listInteractor?.fetchNotes()
  }

  private func configureList() {
    listInteractor = listWireframe.configure(listViewController: listViewController)
  }

  func didSelect(noteID: NoteID) {
    configureEditor(noteID: noteID)
    editorViewController.showNoteScreen()
    editorInteractor?.fetchText()
  }

  private func configureEditor(noteID: NoteID) {
    editorInteractor = editorWireframe.configure(editorViewController: editorViewController, noteID: noteID)
  }

  func didDeselectAllNotes() {
    editorInteractor = nil
    editorViewController.showNoNoteScreen()
  }

  func didModify(text: String) {
    editorInteractor?.save(text: text)
  }

  func didSaveText(for noteID: NoteID) {
    listInteractor?.fetch(noteID: noteID)
  }

  @IBAction func newNote(_ sender: AnyObject) {
    listInteractor?.makeNote()
  }

  func didMake(note: Note) {
    listInteractor?.fetchNotes()
    listViewController.select(noteID: note.id)
    editorViewController.prepareForEditing()
  }
}
