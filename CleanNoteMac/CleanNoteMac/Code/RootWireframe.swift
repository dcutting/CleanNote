import Cocoa
import CleanNoteCore

class RootWireframe {
  func configure(listViewController: ListViewControllerMac, editorContainer: NSViewController) {
    let sampleNotes = makeSampleNotes()
    let noteGateway = InMemoryNoteGateway(notes: sampleNotes)

    ListWireframeMac().configure(listViewController: listViewController, editorContainer: editorContainer, noteGateway: noteGateway)
  }

  private func makeSampleNotes() -> [Note] {
    let noteID1 = "1"
    let noteID2 = "2"
    let note1 = Note(id: noteID1, text: "Hello world")
    let note2 = Note(id: noteID2, text: "Goodbye cruel world")
    return [note1, note2]
  }
}
