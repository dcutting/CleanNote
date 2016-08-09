public protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

public protocol EditorInteractorOutput {
  func update(text: String)
  func didFailToFetchText()
  func didSaveText(for noteID: NoteID)
  func didFailToSaveText()
}

public class EditorInteractor {
  let output: EditorInteractorOutput
  let gateway: NoteGateway
  let noteID: NoteID

  public init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }
}

extension EditorInteractor: EditorInteractorInput {
  public func fetchText() {
    do {
      try gateway.fetchNote(with: noteID) {
        self.output.update(text: $0.text)
      }
    } catch {
      output.didFailToFetchText()
    }
  }

  public func save(text: String) {
    do {
      try gateway.save(text: text, for: noteID)
      output.didSaveText(for: noteID)
    } catch {
      output.didFailToSaveText()
    }
  }
}
