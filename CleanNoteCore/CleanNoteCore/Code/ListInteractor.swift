import Foundation

public enum ListError: LocalizedError, RecoverableError {
  case failToFetchNotes((Void) -> Void)
  case failToMakeNote((Void) -> Void)

  public var errorDescription: String? {
    switch self {
    case .failToFetchNotes: return "Could not fetch the list of notes"
    case .failToMakeNote: return "Could not make a new note"
    }
  }

  public var recoveryOptions: [String] {
    get { return ["Try again", "Cancel"] }
  }

  public func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {
    guard 0 == recoveryOptionIndex else { return false }

    switch self {
    case let .failToFetchNotes(recovery), let .failToMakeNote(recovery):
      recovery()
    }
    return true
  }
}

public protocol ListInteractorInput {
  func fetchNotesAndSelect(noteID: NoteID?)
  func makeNote()
}

public protocol ListInteractorOutput {
  func update(list: List)
  func didFail(error: ListError)
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
        let error = ListError.failToFetchNotes { self.fetchNotesAndSelect(noteID: noteID) }
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
        let error = ListError.failToMakeNote { self.makeNote() }
        self.output.didFail(error: error)
      }
    }
  }
}
