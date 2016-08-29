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

  private func makeFetchError() -> NSError {
    return makeEditorError(code: EditorErrorFailToFetchNote, description: "Could not fetch the note") {
      self.fetchText()
    }
  }

  private func makeSaveError(text: String) -> NSError {
    return makeEditorError(code: EditorErrorFailToSaveNote, description: "Could not save the note") {
      self.save(text: text)
    }
  }

  private func makeEditorError(code: Int, description: String, retry: @escaping (Void) -> Void) -> NSError {
    return makeRetryableError(domain: EditorErrorDomain, code: code, description: description, retry: retry)
  }
}
