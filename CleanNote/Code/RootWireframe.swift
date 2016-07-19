class RootWireframe {
  func configure(listViewController: ListViewController) {
    let sampleNotes = makeSampleNotes()
    let noteGateway = SampleNoteGateway(initialNotes: sampleNotes)

    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    ListWireframe().configure(listViewController: listViewController, noteGateway: noteGateway, editorWireframe: editorWireframe)
  }

  func makeSampleNotes() -> [Note] {
    let noteID1 = "1"
    let noteID2 = "2"
    let note1 = Note(id: noteID1, text: "Hello world")
    let note2 = Note(id: noteID2, text: "Goodbye cruel world")
    return [note1, note2]
  }
}