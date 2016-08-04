class MockEditorInteractorOutput: EditorInteractorOutput {
  var actualText: String?
  var shouldExpectDidFailToFetchText = false
  var shouldExpectDidFailToSaveText = false
  var didCallDidFailToFetchText = false
  var didCallDidFailToSaveText = false

  func didFetch(text: String) {
    actualText = text
  }

  func expectDidFailToFetchText() {
    shouldExpectDidFailToFetchText = true
  }

  func expectDidFailToSaveText() {
    shouldExpectDidFailToSaveText = true
  }

  func didFailToFetchText() {
    didCallDidFailToFetchText = true
  }

  func didFailToSaveText() {
    didCallDidFailToSaveText = true
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
