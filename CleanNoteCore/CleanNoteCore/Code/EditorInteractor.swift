import Foundation

let EditorErrorDomain = "EditorErrorDomain"
let EditorErrorFailToSaveNote = 1
let EditorErrorFailToFetchNote = 2

public protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

public protocol EditorInteractorOutput {
  func update(text: String)
  func didSaveText(for noteID: NoteID)
  func didFail(error: NSError)
}

public class EditorInteractor {
  let output: EditorInteractorOutput
  let gateway: NoteGateway
  let noteID: NoteID

  public init(output: EditorInteractorOutput, gateway: NoteGateway, noteID: NoteID) {
    self.output = output
    self.gateway = gateway
    self.noteID = noteID
  }
}

extension EditorInteractor: EditorInteractorInput {
  public func fetchText() {
    gateway.fetchNote(with: noteID) { result in
      do {
        let note = try result()
        self.output.update(text: note.text)
      } catch {
        let error = self.makeFetchError()
        self.output.didFail(error: error)
      }
    }
  }

  private func makeFetchError() -> NSError {
    let userInfo: [String: Any] = [
      NSLocalizedDescriptionKey: "Could not fetch the note",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem fetching the note.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: RecoveryAttempter(index: 0) { self.fetchText() }
    ]
    return NSError(domain: EditorErrorDomain, code: EditorErrorFailToFetchNote, userInfo: userInfo)
  }

  public func save(text: String) {
    gateway.save(text: text, for: noteID) { result in
      do {
        try result()
        self.output.didSaveText(for: self.noteID)
      } catch {
        let error = self.makeSaveError(text: text)
        self.output.didFail(error: error)
      }
    }
  }

  private func makeSaveError(text: String) -> NSError {
    let userInfo: [String: Any] = [
      NSLocalizedDescriptionKey: "Could not save the note",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem saving the note.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: RecoveryAttempter(index: 0) { self.save(text: text) }
    ]
    return NSError(domain: EditorErrorDomain, code: EditorErrorFailToSaveNote, userInfo: userInfo)
  }
}
