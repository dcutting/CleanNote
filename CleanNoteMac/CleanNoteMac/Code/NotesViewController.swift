import Cocoa
import CleanNoteCore

class NotesViewController: NSSplitViewController, MakerInterface, ListViewControllerDelegate, EditorViewControllerDelegate {

  var listWireframe: ListWireframe!
  var editorWireframe: EditorWireframe!

  var listViewController: ListViewController!
  var editorViewController: EditorViewController!
  var makerInteractor: MakerInteractorInput!

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
    if let noteID = editorInteractor?.noteID {
      listInteractor?.fetch(noteID: noteID)
    }
  }

  @IBAction func newNote(_ sender: AnyObject) {
    makerInteractor?.makeNote()
  }

  func didMake(note: Note) {
    listInteractor?.fetchNotes()
    listViewController.select(noteID: note.id)
    editorViewController.prepareForEditing()
  }
}
