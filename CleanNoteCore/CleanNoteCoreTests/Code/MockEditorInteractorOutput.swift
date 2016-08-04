class MockEditorInteractorOutput: EditorInteractorOutput {
  var actualText: String?
  var shouldExpectDidFailToSave: Bool = false
  var didCallDidFailToSave: Bool = false

  func didFetch(text: String) {
    actualText = text
  }

  func expectDidFailToSave() {
    shouldExpectDidFailToSave = true
  }

  func didFailToSaveText() {
    didCallDidFailToSave = true
  }

  func didFailToFetchText() {
  }

  func assert() -> Bool {
    return shouldExpectDidFailToSave && didCallDidFailToSave
  }
}
