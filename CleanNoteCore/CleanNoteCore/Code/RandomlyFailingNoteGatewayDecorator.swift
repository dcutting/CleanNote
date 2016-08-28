import Foundation

public class RandomlyFailingNoteGatewayDecorator: NoteGateway {
  let noteGateway: NoteGateway
  let failureRate: UInt32

  public init(noteGateway: NoteGateway, failOneIn: Int) {
    self.noteGateway = noteGateway
    self.failureRate = UInt32(failOneIn)
  }

  public func fetchNotes(completion: AsyncThrowable<[Note]>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else {
      noteGateway.fetchNotes(completion: completion)
    }
  }

  public func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else {
      noteGateway.fetchNote(with: id, completion: completion)
    }
  }

  public func makeNote(completion: AsyncThrowable<Note>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else {
      noteGateway.makeNote(completion: completion)
    }
  }

  public func save(text: String, for id: NoteID, completion: AsyncThrowable<Void>) {
    if hasRandomError() {
      completion { throw NoteGatewayError.unknown }
    } else {
      noteGateway.save(text: text, for: id, completion: completion)
    }
  }

  private func hasRandomError() -> Bool {
    guard failureRate > 0 else { return false }
    let random = arc4random_uniform(failureRate)
    return random == 0
  }
}
