protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

protocol EditorInteractorOutput {
  func didFetch(text: String)
}

class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput
  let gateway: NoteGateway
  let noteID: NoteID

  init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }

  func fetchText() {
    gateway.fetchNote(with: noteID) {
      guard let note = $0 else { return }
      self.output.didFetch(text: note.text)
    }
  }

  func save(text: String) {
    gateway.save(text: text, for: noteID)
  }
}
