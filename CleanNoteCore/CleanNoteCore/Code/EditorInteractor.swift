public protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

public protocol EditorInteractorOutput {
  func didFetch(text: String)
  func didFailToSave()
}

public class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput
  let gateway: NoteGateway
  var noteID: NoteID?

  public init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID?) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }

  public func fetchText() {
    if let noteID = noteID {
      fetchText(for: noteID)
    } else {
      fetchTextForNewNote()
    }
  }

  private func fetchText(for noteID: NoteID) {
    gateway.fetchNote(with: noteID) {
      if let note = $0 {
        self.output.didFetch(text: note.text)
      } else {
        self.fetchTextForNewNote()
      }
    }
  }

  private func fetchTextForNewNote() {
    output.didFetch(text: "")
  }

  public func save(text: String) {
    if let noteID = noteID {
      do {
        try gateway.save(text: text, for: noteID)
      } catch {
        output.didFailToSave()
      }
    } else {
      do {
        noteID = try gateway.createNote(with: text)
      } catch {
        output.didFailToSave()
      }
    }
  }
}
