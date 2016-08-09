public class InMemoryNoteGateway: NoteGateway {
  var noteIDCounter = 0
  var notes: [Note]

  public init(notes: [Note]) {
    self.notes = notes
  }

  public func fetchNotes(completion: ([Note]) -> Void) {
    completion(notes)
  }

  public func fetchNote(with id: NoteID, completion: (Note) -> Void) throws {
    guard let note = findNote(with: id) else { throw NoteGatewayError.notFound }
    completion(note)
  }

  private func findNote(with id: NoteID) -> Note? {
    return notes.filter { $0.id == id }.first
  }

  public func makeNote() throws -> Note {
    let nextNoteID = nextID()
    let note = Note(id: nextNoteID, text: "")
    notes.append(note)
    return note
  }

  private func nextID() -> NoteID {
    defer { noteIDCounter += 1 }
    return NoteID("SNG-NID:\(noteIDCounter)")
  }

  public func save(text: String, for id: NoteID) throws {
    guard let index = findIndexForNote(with: id) else { throw NoteGatewayError.notFound }
    var note = notes[index]
    note.text = text
    notes[index] = note
  }

  private func findIndexForNote(with id: NoteID) -> Int? {
    return notes.index { $0.id == id }
  }
}
