import Foundation

public let EditorErrorDomain = "EditorErrorDomain"
public let EditorErrorFailToSaveNote = 1
public let EditorErrorFailToFetchNote = 2

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
    return makeEditorError(description: "Could not fetch the note", suggestion: "There was a temporary problem fetching the note.") {
      self.fetchText()
    }
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
    return makeEditorError(description: "Could not save the note", suggestion: "There was a temporary problem saving the note.") {
      self.save(text: text)
    }
  }

  private func makeEditorError(description: String, suggestion: String, retry: @escaping (Void) -> Void) -> NSError {
    return makeError(domain: EditorErrorDomain,
                     code: EditorErrorFailToSaveNote,
                     description: description,
                     suggestion: suggestion,
                     options: ["Try again", "Cancel"],
                     recovery: RecoveryAttempter(index: 0, handler: retry))
  }
}
