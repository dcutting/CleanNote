protocol ListInteractorInput {
  func fetchNotes()
}

protocol ListInteractorOutput {
  func didFetch(notes: [Note])
}

class ListInteractor: ListInteractorInput {
  let output: ListInteractorOutput
  let service: NoteService

  init(output: ListInteractorOutput, service: NoteService) {
    self.output = output
    self.service = service
  }

  func fetchNotes() {
    service.fetchNotes {
      self.output.didFetch(notes: $0)
    }
  }
}
