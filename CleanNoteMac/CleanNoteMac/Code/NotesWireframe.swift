import Cocoa
import CleanNoteCore

class NotesWireframe {
  func configure(notesViewController: NotesViewController) {

    let sampleNotes = makeSampleNotes()
    let noteGateway = InMemoryNoteGateway(notes: sampleNotes)

    let listWireframe = ListWireframe(noteGateway: noteGateway)
    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    notesViewController.listWireframe = listWireframe
    notesViewController.editorWireframe = editorWireframe

    configureChildrenViewControllers()
    configureDelegates()
  }

  private func configureChildrenControllers() {
    notesViewController.listViewController = notesViewController.childViewControllers[0] as! ListViewController
    notesViewController.editorViewController = notesViewController.childViewControllers[1] as! EditorViewController
  }

  private func configureDelegates() {
    notesViewController.listViewController.delegate = notesViewController
    notesViewController.editorViewController.delegate = notesViewController
  }
  
  private func makeSampleNotes() -> [Note] {
    let noteID1 = "1"
    let noteID2 = "2"
    let note1 = Note(id: noteID1, text: "Hello world")
    let note2 = Note(id: noteID2, text: "Goodbye cruel world")
    return [note1, note2]
  }
}
