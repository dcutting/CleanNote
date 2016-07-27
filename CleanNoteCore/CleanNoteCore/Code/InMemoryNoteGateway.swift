class InMemoryNoteGateway: NoteGateway {
  var noteIDCounter = 0
  var notes: [Note]

  init(notes: [Note]) {
    self.notes = notes
  }

  func fetchNotes(completion: ([Note]) -> Void) {
    completion(notes)
  }

  func fetchNote(with id: NoteID, completion: (Note?) -> Void) {
    let note = findNote(with: id)
    completion(note)
  }

  private func findNote(with id: NoteID) -> Note? {
    return notes.filter { $0.id == id }.first
  }

  func createNote(with text: String) throws -> NoteID {
    let nextNoteID = nextID()
    let note = Note(id: nextNoteID, text: text)
    notes.append(note)
    return nextNoteID
  }

  private func nextID() -> NoteID {
    defer { noteIDCounter += 1 }
    return NoteID("SNG-NID:\(noteIDCounter)")
  }

  func save(text: String, for id: NoteID) throws {
    guard let index = findIndexForNote(with: id) else { throw NoteGatewayError.notFound }
    var note = notes[index]
    note.text = text
    notes[index] = note
  }

  private func findIndexForNote(with id: NoteID) -> Int? {
    return notes.index { $0.id == id }
  }
}
