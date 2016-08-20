import Cocoa
import CleanNoteCore

class NotesWireframe {
  func configure(notesViewController: NotesViewController) {

    let shouldFailRandomly = true

    let sampleNotes = makeSampleNotes()
    let noteGateway = InMemoryNoteGateway(notes: sampleNotes, shouldFailRandomly: shouldFailRandomly)

    let listWireframe = ListWireframe(noteGateway: noteGateway)
    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    notesViewController.listWireframe = listWireframe
    notesViewController.editorWireframe = editorWireframe

    configureChildrenViewControllers(for: notesViewController)
    configureDelegates(for: notesViewController)
  }

  private func configureChildrenViewControllers(for notesViewController: NotesViewController) {
    notesViewController.listViewController = notesViewController.childViewControllers[0] as! ListViewController
    notesViewController.editorViewController = notesViewController.childViewControllers[1] as! EditorViewController
  }

  private func configureDelegates(for notesViewController: NotesViewController) {
    notesViewController.listViewController.delegate = notesViewController
    notesViewController.editorViewController.delegate = notesViewController
  }
  
  private func makeSampleNotes() -> [Note] {
    let note1 = Note(id: "1", text: "Hello world")
    let note2 = Note(id: "2", text: "Goodbye cruel world")
    return [note1, note2]
  }
}
