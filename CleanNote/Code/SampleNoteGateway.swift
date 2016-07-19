class SampleNoteGateway: NoteGateway {
  var noteIDCounter = 0
  var notes = [NoteID: Note]()

  init(initialNotes: [Note]) {
    initialNotes.forEach {
      self.notes[$0.id] = $0
    }
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

  func createNote(with text: String) {
    let nextNoteID = nextID()
    let note = Note(id: nextNoteID, text: text)
    notes[nextNoteID] = note
  }

  func nextID() -> NoteID {
    defer { noteIDCounter += 1 }
    return NoteID("SNG-NID:\(noteIDCounter)")
  }

  func save(text: String, for noteID: NoteID) {
    guard var note = notes[noteID] else { return }
    note.text = text
    notes[noteID] = note
  }
}
