public protocol ListInteractorInput {
  func fetchNotes()
  func fetch(noteID: NoteID)
}

public protocol ListInteractorOutput {
  func didFetch(notes: [Note])
  func didFetch(note: Note)
}

public class ListInteractor: ListInteractorInput {
  let output: ListInteractorOutput
  let gateway: NoteGateway

  public init(output: ListInteractorOutput, gateway: NoteGateway) {
    self.output = output
    self.gateway = gateway
  }

  public func fetchNotes() {
    gateway.fetchNotes {
      self.output.didFetch(notes: $0)
    }
  }

  public func fetch(noteID: NoteID) {
    gateway.fetchNote(with: noteID) {
      guard let note = $0 else { return }
      self.output.didFetch(note: note)
    }
  }
}
