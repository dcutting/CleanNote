import Foundation

public let ListErrorDomain = "ListErrorDomain"
public let ListErrorFailToMakeNote = 1

public protocol ListInteractorInput {
  func fetchNotesAndSelect(noteID: NoteID?)
  func makeNote()
}

public protocol ListInteractorOutput {
  func update(list: List)
  func didFailToMakeNote(error: NSError)
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
    gateway.fetchNotes { notes in
      let list = List(notes: notes, selected: noteID)
      self.output.update(list: list)
    }
  }

  public func makeNote() {
    do {
      let note = try gateway.makeNote()
      fetchNotesAndSelect(noteID: note.id)
    } catch {
      let error = makeError()
      output.didFailToMakeNote(error: error)
    }
  }

  private func makeError() -> NSError {
    let recoveryAttempter = MakeNoteRecovery(interactor: self)
    let userInfo = [
      NSLocalizedDescriptionKey: "Could not make a new note",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem making a new note.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: recoveryAttempter
    ]
    return NSError(domain: ListErrorDomain, code: ListErrorFailToMakeNote, userInfo: userInfo)
  }
}

class MakeNoteRecovery: NSObject {

  let interactor: ListInteractor

  init(interactor: ListInteractor) {
    self.interactor = interactor
  }

  override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int, delegate: AnyObject?, didRecoverSelector: Selector?, contextInfo: UnsafeMutablePointer<Void>?) {
    guard recoveryOptionIndex == 0 else { return }
    interactor.makeNote()
  }
}
