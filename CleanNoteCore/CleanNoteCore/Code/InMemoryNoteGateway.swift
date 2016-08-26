import Foundation

public class InMemoryNoteGateway: NoteGateway {
  var noteIDCounter = 0
  var notes: [Note]
  let shouldFailRandomly: Bool

  public init(notes: [Note], shouldFailRandomly: Bool) {
    self.notes = notes
    self.shouldFailRandomly = shouldFailRandomly
  }

  public func fetchNotes(completion: AsyncThrowable<[Note]>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else {
      completion { return notes }
    }
  }

  public func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else if let note = findNote(with: id) {
      completion { return note }
    } else {
      completion { throw NoteGatewayError.notFound }
    }
  }

  private func findNote(with id: NoteID) -> Note? {
    return notes.filter { $0.id == id }.first
  }

  public func makeNote(completion: AsyncThrowable<Note>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else {
      let nextNoteID = nextID()
      let note = Note(id: nextNoteID, text: "")
      notes.append(note)
      completion { return note }
    }
  }

  private func hasRandomError() -> Bool {
    guard shouldFailRandomly else { return false }
    let random = arc4random_uniform(1)
    return random == 0
  }

  private func nextID() -> NoteID {
    defer { noteIDCounter += 1 }
    return NoteID("NID:\(noteIDCounter)")
  }

  public func save(text: String, for id: NoteID) throws {
    guard hasRandomError() == false else { throw NoteGatewayError.unknown }
    guard let index = indexFor(noteID: id) else { throw NoteGatewayError.notFound }
    var note = notes[index]
    note.text = text
    notes[index] = note
  }

  private func indexFor(noteID: NoteID) -> Int? {
    return notes.index { $0.id == noteID }
  }
}
