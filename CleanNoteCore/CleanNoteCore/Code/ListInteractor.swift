import Foundation

public let ListErrorDomain = "ListErrorDomain"
public let ListErrorFailToFetchNotes = 1
public let ListErrorFailToMakeNote = 2

public protocol ListInteractorInput {
  func fetchNotesAndSelect(noteID: NoteID?)
  func makeNote()
}

public protocol ListInteractorOutput {
  func update(list: List)
  func didFail(error: NSError)
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
        let error = self.makeFetchError(noteID: noteID)
        self.output.didFail(error: error)
      }
    }
  }

  private func makeFetchError(noteID: NoteID?) -> NSError {
    let userInfo: [String: Any] = [
      NSLocalizedDescriptionKey: "Could not fetch the list of notes",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem fetching the notes.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: RecoveryAttempter(index: 0) { self.fetchNotesAndSelect(noteID: noteID) }
    ]
    return NSError(domain: ListErrorDomain, code: ListErrorFailToFetchNotes, userInfo: userInfo)
  }

  public func makeNote() {
    gateway.makeNote() { result in
      do {
        let note = try result()
        self.fetchNotesAndSelect(noteID: note.id)
      } catch {
        let error = self.makeMakeNoteError()
        self.output.didFail(error: error)
      }
    }
  }

  private func makeMakeNoteError() -> NSError {
    let userInfo: [String: Any] = [
      NSLocalizedDescriptionKey: "Could not make a new note",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem making a new note.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: RecoveryAttempter(index: 0) { self.makeNote() }
    ]
    return NSError(domain: ListErrorDomain, code: ListErrorFailToMakeNote, userInfo: userInfo)
  }
}
