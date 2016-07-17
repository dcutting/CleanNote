class SampleNoteGateway: NoteGateway {
  var notes: [NoteID: Note]

  init() {
    let noteID1 = "1"
    let noteID2 = "2"
    let note1 = Note(id: noteID1, text: "Hello world")
    let note2 = Note(id: noteID2, text: "Goodbye cruel world")
    notes = [noteID1: note1, noteID2: note2]
  }

  func fetchNotes(completion: ([Note]) -> Void) {
    let sortedNotes = notes.values.sorted {
      $0.id < $1.id
    }
    completion(Array(sortedNotes))
  }

  func fetchNote(with id: NoteID, completion: (Note?) -> Void) {
    let note = notes[id]
    completion(note)
  }

  func save(text: String, for noteID: NoteID) {
    guard var note = notes[noteID] else { return }
    note.text = text
    notes[noteID] = note
  }
}
