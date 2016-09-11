import CleanNoteCore

class MockEditorInterface: EditorInterface {
  var spiedUpdateText: String?
  var spiedPresentError: RetryableError<EditorError>?

  func update(text: String) {
    spiedUpdateText = text
  }

  func present(error: RetryableError<EditorError>) {
    spiedPresentError = error
  }

  public func didSaveText(for noteID: NoteID) {
  }
}
