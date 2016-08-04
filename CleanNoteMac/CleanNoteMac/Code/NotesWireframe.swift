import Cocoa
import CleanNoteCore

class NotesWireframe {
  func configure(notesViewController: NotesViewController) {

    let sampleNotes = makeSampleNotes()
    let noteGateway = InMemoryNoteGateway(notes: sampleNotes)

    let listWireframe = ListWireframe(noteGateway: noteGateway)
    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    notesViewController.noteGateway = noteGateway
    notesViewController.listWireframe = listWireframe
    notesViewController.editorWireframe = editorWireframe
  }

  private func makeSampleNotes() -> [Note] {
    let noteID1 = "1"
    let noteID2 = "2"
    let note1 = Note(id: noteID1, text: "Hello world")
    let note2 = Note(id: noteID2, text: "Goodbye cruel world")
    return [note1, note2]
  }
}
