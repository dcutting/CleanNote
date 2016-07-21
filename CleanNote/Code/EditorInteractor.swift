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
  let noteID: NoteID?

  init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID?) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }

  func fetchText() {
    if let noteID = noteID {
      fetchText(for: noteID)
    } else {
      fetchTextForNewNote()
    }
  }

  func fetchText(for noteID: NoteID) {
    gateway.fetchNote(with: noteID) {
      if let note = $0 {
        self.output.didFetch(text: note.text)
      } else {
        self.fetchTextForNewNote()
      }
    }
  }

  func fetchTextForNewNote() {
    output.didFetch(text: "")
  }

  func save(text: String) {
    if let noteID = noteID {
      gateway.save(text: text, for: noteID)
    } else {
      let _ = gateway.createNote(with: text)
    }
  }
}
