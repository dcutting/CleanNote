class EditorWireframe {
  let noteGateway: NoteGateway

  init(noteGateway: NoteGateway) {
    self.noteGateway = noteGateway
  }

  func configure(editorViewController: EditorViewController, noteID: NoteID?) {
    let editorPresenter = EditorPresenter(interface: editorViewController)
    let editorInteractor = EditorInteractor(output: editorPresenter, gateway: noteGateway, noteID: noteID)
    editorViewController.interactor = editorInteractor
  }
}
