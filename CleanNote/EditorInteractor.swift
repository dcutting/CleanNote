protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

protocol EditorInteractorOutput {
  func didFetch(text: String)
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

  func fetchText() {
    service.fetchNote(with: noteID) {
      guard let note = $0 else { return }
      self.output.didFetch(text: note.text)
    }
  }

  func save(text: String) {
    service.save(text: text, for: noteID)
  }
}
