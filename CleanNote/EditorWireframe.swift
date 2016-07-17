class EditorWireframe {
  func configure(editorViewController: EditorViewController, noteService: NoteService, noteID: NoteID) {
    let editorPresenter = EditorPresenter(interface: editorViewController)
    let editorInteractor = EditorInteractor(output: editorPresenter, service: noteService, noteID: noteID)
    editorViewController.interactor = editorInteractor
  }
}
