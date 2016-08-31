import Foundation

public enum ListError: LocalizedError {
  case failToFetchNotes
  case failToMakeNote

  public var errorDescription: String? {
    switch self {
    case .failToFetchNotes: return "Could not fetch the list of notes"
    case .failToMakeNote: return "Could not make a new note"
    }
  }
}

public protocol ListInteractorInput {
  func fetchNotesAndSelect(noteID: NoteID?)
  func makeNote()
}

public protocol ListInteractorOutput {
  func update(list: List)
  func didFail(error: RetryableError<ListError>)
}

public class ListInteractor {
  let output: ListInteractorOutput
  let gateway: NoteGateway

  public init(output: ListInteractorOutput, gateway: NoteGateway) {
    self.output = output
    self.gateway = gateway
  }
}

extension ListInteractor: ListInteractorInput {
  public func fetchNotesAndSelect(noteID: NoteID?) {
    gateway.fetchNotes() { result in
      do {
        let notes = try result()
        let list = List(notes: notes, selected: noteID)
        self.output.update(list: list)
      } catch {
        let error = RetryableError(code: ListError.failToFetchNotes) { self.fetchNotesAndSelect(noteID: noteID) }
        self.output.didFail(error: error)
      }
    }
  }

  public func makeNote() {
    gateway.makeNote() { result in
      do {
        let note = try result()
        self.fetchNotesAndSelect(noteID: note.id)
      } catch {
        let error = RetryableError(code: ListError.failToMakeNote) { self.makeNote() }
        self.output.didFail(error: error)
      }
    }
  }
}
