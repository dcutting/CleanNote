struct EditorViewNote {
  var text: String
}

protocol EditorInterface {
  func update(note: EditorViewNote)
}

class EditorPresenter: EditorInteractorOutput {
  let interface: EditorInterface

  init(interface: EditorInterface) {
    self.interface = interface
  }

  func didPrepare(note: EditorNote) {
    let editorViewNote = EditorViewNote(text: note.text)
    interface.update(note: editorViewNote)
  }
}
