struct EditorNote {
  var noteID: NoteID?
  var text: String
}

protocol EditorInteractorInput {
  func prepareNote()
}

protocol EditorInteractorOutput {
  func didPrepare(note: EditorNote)
}

class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput
  var editorNote: EditorNote

  init(output: EditorInteractorOutput, editorNote: EditorNote) {
    self.output = output
    self.editorNote = editorNote
  }

  func prepareNote() {
    output.didPrepare(note: editorNote)
  }
}
