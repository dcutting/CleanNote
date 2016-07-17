class EditorWireframe {
  let noteService: NoteService

  init(noteService: NoteService) {
    self.noteService = noteService
  }

  func configure(editorViewController: EditorViewController, noteID: NoteID) {
    let editorPresenter = EditorPresenter(interface: editorViewController)
    let editorInteractor = EditorInteractor(output: editorPresenter, service: noteService, noteID: noteID)
    editorViewController.interactor = editorInteractor
  }
}
