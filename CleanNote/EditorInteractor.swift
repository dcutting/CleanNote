protocol EditorInteractorInput {
  func prepareNote()
}

protocol EditorInteractorOutput {
  func didPrepare(note: Note)
}

class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput
  let service: NoteService
  let noteID: NoteID

  init(output: EditorInteractorOutput, service: NoteService, noteID: NoteID) {
    self.output = output
    self.service = service
    self.noteID = noteID
  }

  func prepareNote() {
    service.fetchNote(with: noteID) {
      guard let note = $0 else { return }
      self.output.didPrepare(note: note)
    }
  }
}
