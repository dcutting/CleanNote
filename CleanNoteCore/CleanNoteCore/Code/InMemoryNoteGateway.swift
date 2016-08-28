public class InMemoryNoteGateway: NoteGateway {
  var noteIDCounter = 0
  var notes: [Note]

  public init(notes: [Note]) {
    self.notes = notes
  }

  public func fetchNotes(completion: AsyncThrowable<[Note]>) {
    completion { return notes }
  }

  public func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>) {
    if let note = findNote(with: id) {
      completion { return note }
    } else {
      completion { throw NoteGatewayError.notFound }
    }
  }

  private func findNote(with id: NoteID) -> Note? {
    return notes.filter { $0.id == id }.first
  }

  public func makeNote(completion: AsyncThrowable<Note>) {
    let nextNoteID = nextID()
    let note = Note(id: nextNoteID, text: "")
    notes.append(note)
    completion { return note }
  }

  private func nextID() -> NoteID {
    defer { noteIDCounter += 1 }
    return NoteID("NID:\(noteIDCounter)")
  }

  public func save(text: String, for id: NoteID, completion: AsyncThrowable<Void>) {
    if let index = indexFor(noteID: id) {
      var note = notes[index]
      note.text = text
      notes[index] = note
      completion {}
    } else {
      completion { throw NoteGatewayError.notFound }
    }
  }

  private func indexFor(noteID: NoteID) -> Int? {
    return notes.index { $0.id == noteID }
  }
}
