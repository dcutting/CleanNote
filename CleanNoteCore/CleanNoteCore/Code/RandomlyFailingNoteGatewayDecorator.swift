public protocol ErrorGenerator {
  func hasError() -> Bool
}

public class RandomlyFailingNoteGatewayDecorator: NoteGateway {
  let noteGateway: NoteGateway
  let errorGenerator: ErrorGenerator

  public init(noteGateway: NoteGateway, errorGenerator: ErrorGenerator) {
    self.noteGateway = noteGateway
    self.errorGenerator = errorGenerator
  }

  public func fetchNotes(completion: @escaping AsyncThrowable<[Note]>) {
    run(completion: completion) {
      noteGateway.fetchNotes(completion: completion)
    }
  }

  public func fetchNote(with id: NoteID, completion: @escaping AsyncThrowable<Note>) {
    run(completion: completion) {
      noteGateway.fetchNote(with: id, completion: completion)
    }
  }

  public func makeNote(completion: @escaping AsyncThrowable<Note>) {
    run(completion: completion) {
      noteGateway.makeNote(completion: completion)
    }
  }

  public func save(text: String, for id: NoteID, completion: @escaping AsyncThrowable<Void>) {
    run(completion: completion) {
      noteGateway.save(text: text, for: id, completion: completion)
    }
  }

  private func run<T>(completion: AsyncThrowable<T>, operation: (Void) -> Void) {
    do {
      try maybeError()
      operation()
    } catch {
      completion { throw error }
    }
  }

  private func maybeError() throws {
    if errorGenerator.hasError() {
      throw NoteGatewayError.unknown
    }
  }
}
