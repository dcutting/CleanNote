import Cocoa
import CleanNoteCore

class NotesViewController: NSSplitViewController, ListViewControllerDelegate, EditorViewControllerDelegate {

  var noteGateway: NoteGateway!
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
    if let noteID = editorInteractor?.noteID {
      listInteractor?.fetch(noteID: noteID)
    }
  }

  @IBAction func newNote(_ sender: AnyObject) {
    do {
      try createAndEditNote()
    } catch {
      show(error: "Could not create note")
    }
  }

  func createAndEditNote() throws {
    let noteID = try noteGateway.createNote()
    listInteractor?.fetchNotes()
    listViewController.select(noteID: noteID)
    editorViewController.prepareForEditing()
  }

  func show(error: String) {
    guard let window = view.window else { return }
    let alert = NSAlert()
    alert.messageText = error
    alert.beginSheetModal(for: window)
  }
}
