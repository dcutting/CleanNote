public protocol EditorInteractorInput {
  var noteID: NoteID { get }
  func fetchText()
  func save(text: String)
}

public protocol EditorInteractorOutput {
  func didFetch(text: String)
  func didFailToFetchText()
  func didFailToSaveText()
}

public class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput
  let gateway: NoteGateway

  public let noteID: NoteID

  public init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }

  public func fetchText() {
    gateway.fetchNote(with: noteID) {
      if let note = $0 {
        self.output.didFetch(text: note.text)
      } else {
        self.output.didFailToFetchText()
      }
    }
  }

  public func save(text: String) {
    do {
      try gateway.save(text: text, for: noteID)
    } catch {
      output.didFailToSaveText()
    }
  }
}
