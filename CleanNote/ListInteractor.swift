protocol ListInteractorInput {
  func fetchNotes()
}

protocol ListInteractorOutput {
  func didFetch(notes: [Note])
}

class ListInteractor: ListInteractorInput {
  let output: ListInteractorOutput
  let gateway: NoteGateway

  init(output: ListInteractorOutput, gateway: NoteGateway) {
    self.output = output
    self.gateway = gateway
  }

  func fetchNotes() {
    gateway.fetchNotes {
      self.output.didFetch(notes: $0)
    }
  }
}
