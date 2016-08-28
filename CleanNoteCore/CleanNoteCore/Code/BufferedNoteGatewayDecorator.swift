import Foundation

public class BufferedNoteGatewayDecorator: NoteGateway {
  let noteGateway: NoteGateway
  var cachedNotes: [Note]?

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
      clearCache()
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
    noteGateway.save(text: text, for: id) { result in
      do {
        try result()
        self.clearCache()
        completion {}
      } catch {
        completion { throw error }
      }
    }
  }

  private func cache(notes: [Note]) {
    cachedNotes = notes
  }

  private func clearCache() {
    cachedNotes = nil
  }
}
