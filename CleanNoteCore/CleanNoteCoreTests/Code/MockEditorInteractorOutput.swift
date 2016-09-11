import CleanNoteCore

class MockEditorInteractorOutput: EditorInteractorOutput {
  var spiedUpdateText: String?
  var shouldExpectDidFailToFetchText = false
  var shouldExpectDidFailToSaveText = false
  var didCallDidFailToFetchText = false
  var didCallDidFailToSaveText = false

  func update(text: String) {
    spiedUpdateText = text
  }

  func didSaveText(for noteID: NoteID) {
  }

  func didFail(error: RetryableError<EditorError>) {
  }

  func expectDidFailToFetchText() {
    shouldExpectDidFailToFetchText = true
  }

  func expectDidFailToSaveText() {
    shouldExpectDidFailToSaveText = true
  }

  func assert() -> Bool {
    if shouldExpectDidFailToFetchText {
      return didCallDidFailToFetchText
    }
    if shouldExpectDidFailToSaveText {
      return didCallDidFailToSaveText
    }
    return true
  }
}
