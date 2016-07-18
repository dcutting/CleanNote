class RootWireframe {
  func configure(listViewController: ListViewController) {
    let noteGateway = SampleNoteGateway()

    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    ListWireframe().configure(listViewController: listViewController, noteGateway: noteGateway, editorWireframe: editorWireframe)
  }
}
