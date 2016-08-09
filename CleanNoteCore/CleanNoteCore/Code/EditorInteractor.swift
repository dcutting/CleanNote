public protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

public protocol EditorInteractorOutput {
  func didFetch(text: String)
  func didFailToFetchText()
  func didSaveText(for noteID: NoteID)
  func didFailToSaveText()
}

public class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput
  let gateway: NoteGateway

  let noteID: NoteID

  public init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }

  public func fetchText() {
    do {
      try gateway.fetchNote(with: noteID) {
        self.output.didFetch(text: $0.text)
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
