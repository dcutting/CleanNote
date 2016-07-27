public protocol ListInteractorInput {
  func fetchNotes()
}

public protocol ListInteractorOutput {
  func didFetch(notes: [Note])
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
}
