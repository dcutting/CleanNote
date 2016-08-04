import CleanNoteCore

class EditorWireframeMac {
  let noteGateway: NoteGateway

  init(noteGateway: NoteGateway) {
    self.noteGateway = noteGateway
  }

  func configure(editorViewController: EditorViewControllerMac, noteID: NoteID) -> EditorInteractor {
    let editorPresenter = EditorPresenter(interface: editorViewController)
    let editorInteractor = EditorInteractor(output: editorPresenter, gateway: noteGateway, noteID: noteID)
    return editorInteractor
  }
}
