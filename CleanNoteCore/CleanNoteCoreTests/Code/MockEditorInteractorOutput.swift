import CleanNoteCore

class MockEditorInteractorOutput: EditorInteractorOutput {
  var spiedUpdateText: String?
  var spiedDidSaveTextForNoteID: NoteID?
  var spiedDidFail: RetryableError<EditorError>?

  func update(text: String) {
    spiedUpdateText = text
  }

  func didSaveText(for noteID: NoteID) {
    spiedDidSaveTextForNoteID = noteID
  }

  func didFail(error: RetryableError<EditorError>) {
    spiedDidFail = error
  }
}
