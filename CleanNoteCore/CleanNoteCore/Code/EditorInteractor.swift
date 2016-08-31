import Foundation

public enum EditorError: LocalizedError {
  case failToFetchNote
  case failToSaveNote

  public var errorDescription: String? {
    switch self {
    case .failToFetchNote: return "Could not fetch the note"
    case .failToSaveNote: return "Could not save the note"
    }
  }
}

public protocol EditorInteractorInput {
  func fetchText()
  func save(text: String)
}

public protocol EditorInteractorOutput {
  func update(text: String)
  func didSaveText(for noteID: NoteID)
  func didFail(error: RetryableError<EditorError>)
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
        let error = RetryableError(code: EditorError.failToFetchNote) { self.fetchText() }
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
        let error = RetryableError(code: EditorError.failToSaveNote) { self.save(text: text) }
        self.output.didFail(error: error)
      }
    }
  }
}
