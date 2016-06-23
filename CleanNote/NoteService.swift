class NoteService {
    func fetchNotes(completion: ([Note]) -> Void) {
        let note1 = Note(id: "1", text: "Hello world")
        let note2 = Note(id: "2", text: "Goodbye cruel world")
        completion([note1, note2])
    }
}
