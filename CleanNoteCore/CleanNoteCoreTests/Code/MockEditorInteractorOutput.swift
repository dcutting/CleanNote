import CleanNoteCore

class MockEditorInteractorOutput: EditorInteractorOutput {
  var spiedUpdateText: String?
  var spiedDidSaveTextForNoteID: NoteID?
  var spiedDidFail: RetryableError<EditorError>?

//  var shouldExpectDidFailToFetchText = false
//  var shouldExpectDidFailToSaveText = false
//  var didCallDidFailToFetchText = false
//  var didCallDidFailToSaveText = false

  func update(text: String) {
    spiedUpdateText = text
  }

  func didSaveText(for noteID: NoteID) {
    spiedDidSaveTextForNoteID = noteID
  }

  func didFail(error: RetryableError<EditorError>) {
    spiedDidFail = error
  }

//  func expectDidFailToFetchText() {
//    shouldExpectDidFailToFetchText = true
//  }
//
//  func expectDidFailToSaveText() {
//    shouldExpectDidFailToSaveText = true
//  }
//
//  func assert() -> Bool {
//    if shouldExpectDidFailToFetchText {
//      return didCallDidFailToFetchText
//    }
//    if shouldExpectDidFailToSaveText {
//      return didCallDidFailToSaveText
//    }
//    return true
//  }
}
