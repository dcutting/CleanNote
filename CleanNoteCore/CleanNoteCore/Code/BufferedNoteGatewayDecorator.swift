import Foundation

public class BufferedNoteGatewayDecorator: NoteGateway {
  let noteGateway: NoteGateway
  var cachedNotes: [Note]?
  var dirty = false

  public init(noteGateway: NoteGateway) {
    self.noteGateway = noteGateway
  }

  public func fetchNotes(completion: AsyncThrowable<[Note]>) {
    if let notes = cachedNotes {
      completion { return notes }
    } else {
      noteGateway.fetchNotes() { result in
        do {
          let notes = try result()
          self.cache(notes: notes)
          completion { return notes }
        } catch {
          completion { throw error }
        }
      }
    }
  }

  public func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>) {
    if let note = find(noteID: id, in: cachedNotes) {
      completion { return note }
    } else {
      noteGateway.fetchNote(with: id, completion: completion)
    }
  }

  private func find(noteID: NoteID, in notes: [Note]?) -> Note? {
    return notes?.filter { $0.id == noteID }.first
  }

  public func makeNote(completion: AsyncThrowable<Note>) {
    clearCache()
    noteGateway.makeNote(completion: completion)
  }

  public func save(text: String, for id: NoteID, completion: AsyncThrowable<Void>) {
    if let index = indexFor(noteID: id, in: cachedNotes) {
      var note = cachedNotes![index]
      note.text = text
      cachedNotes![index] = note
      dirty = true
      completion {}
    } else {
      noteGateway.save(text: text, for: id, completion: completion)
    }
  }

  private func indexFor(noteID: NoteID, in notes: [Note]?) -> Int? {
    return notes?.index { $0.id == noteID }
  }

  private func cache(notes: [Note]) {
    cachedNotes = notes
    dirty = false
  }

  private func clearCache() {
    cachedNotes = nil
    dirty = false
  }
}
