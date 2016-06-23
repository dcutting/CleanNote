protocol ListInteractorInput {
    func fetchNotes()
}

protocol ListInteractorOutput {
    func found(notes: [Note])
}

class ListInteractor: ListInteractorInput {
    let output: ListInteractorOutput
    let service: NoteService

    init(service: NoteService, output: ListInteractorOutput) {
        self.service = service
        self.output = output
    }

    func fetchNotes() {
        service.fetchNotes {
            self.output.found(notes: $0)
        }
    }
}
