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
  func didFailToFetchText(error: NSError)
  func didSaveText(for noteID: NoteID)
  func didFailToSaveText(error: NSError)
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
    do {
      try gateway.fetchNote(with: noteID) {
        self.output.update(text: $0.text)
      }
    } catch {
      let error = makeFetchError()
      output.didFailToFetchText(error: error)
    }
  }

  private func makeFetchError() -> NSError {
    let recoveryAttempter = FetchRecovery(interactor: self)
    let userInfo = [
      NSLocalizedDescriptionKey: "Could not fetch the note",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem fetching the note.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: recoveryAttempter
    ]
    return NSError(domain: EditorErrorDomain, code: EditorErrorFailToFetchNote, userInfo: userInfo)
  }

  public func save(text: String) {
    do {
      try gateway.save(text: text, for: noteID)
      output.didSaveText(for: noteID)
    } catch {
      let error = makeSaveError(text: text)
      output.didFailToSaveText(error: error)
    }
  }

  private func makeSaveError(text: String) -> NSError {
    let recoveryAttempter = SaveRecovery(interactor: self, text: text)
    let userInfo = [
      NSLocalizedDescriptionKey: "Could not save the note",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem saving the note.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: recoveryAttempter
    ]
    return NSError(domain: EditorErrorDomain, code: EditorErrorFailToSaveNote, userInfo: userInfo)
  }
}

class FetchRecovery: NSObject {

  let interactor: EditorInteractor

  init(interactor: EditorInteractor) {
    self.interactor = interactor
  }

  override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int, delegate: AnyObject?, didRecoverSelector: Selector?, contextInfo: UnsafeMutablePointer<Void>?) {
    guard recoveryOptionIndex == 0 else { return }
    interactor.fetchText()
  }
}

class SaveRecovery: NSObject {

  let interactor: EditorInteractor
  let text: String

  init(interactor: EditorInteractor, text: String) {
    self.interactor = interactor
    self.text = text
  }

  override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int, delegate: AnyObject?, didRecoverSelector: Selector?, contextInfo: UnsafeMutablePointer<Void>?) {
    guard recoveryOptionIndex == 0 else { return }
    interactor.save(text: text)
  }
}
