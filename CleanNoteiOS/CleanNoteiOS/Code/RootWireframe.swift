import CleanNoteCore

class RootWireframe {
  func configure(listViewController: ListViewController) {
    let sampleNotes = makeSampleNotes()
    let noteGateway = InMemoryNoteGateway(notes: sampleNotes, shouldFailRandomly: false)

    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    ListWireframe().configure(listViewController: listViewController, noteGateway: noteGateway, editorWireframe: editorWireframe)
  }

  private func makeSampleNotes() -> [Note] {
    let note1 = Note(id: "1", text: "Hello world")
    let note2 = Note(id: "2", text: "Goodbye cruel world")
    return [note1, note2]
  }
}
