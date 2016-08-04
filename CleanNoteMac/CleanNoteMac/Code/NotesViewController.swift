import Cocoa
import CleanNoteCore

class NotesViewController: NSSplitViewController, ListViewControllerMacDelegate, EditorViewControllerMacDelegate {

  var listViewController: ListViewControllerMac!
  var editorViewController: EditorViewControllerMac!

  var noteGateway: NoteGateway?
  var listInteractor: ListInteractorInput?
  var editorInteractor: EditorInteractorInput?

  var listWireframe: ListWireframeMac?
  var editorWireframe: EditorWireframeMac?

  override func viewDidLoad() {
    configureAppearance()
    configureChildrenControllers()
    super.viewDidLoad()
  }
  
  private func configureAppearance() {
    view.wantsLayer = true   // To enable round window corners.
  }

  private func configureChildrenControllers() {
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

  private func configureList() {
    listInteractor = listWireframe?.configure(listViewController: listViewController)
  }

  func didSelect(noteID: NoteID) {
    configureEditor(noteID: noteID)
    editorViewController.showNoteScreen()
    editorInteractor?.fetchText()
  }

  private func configureEditor(noteID: NoteID) {
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
    do {
      guard let noteID = try noteGateway?.createNote(with: "") else { return }
      listInteractor?.fetchNotes()
      listViewController.select(noteID: noteID)
      editorViewController.prepareForEditing()
    } catch {}
  }
}
