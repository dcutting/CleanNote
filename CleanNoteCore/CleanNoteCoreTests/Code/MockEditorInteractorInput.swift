class MockEditorInteractorInput: EditorInteractorInput {
  var shouldExpectFetchText = false
  var didCallFetchText = false
  var expectedSaveText: String?
  var actualSaveText: String?

  func expectFetchText() {
    shouldExpectFetchText = true
  }

  func expect(save text: String) {
    expectedSaveText = text
  }

  func assert() -> Bool {
    if shouldExpectFetchText && !didCallFetchText {
      return false
    }
    if nil != expectedSaveText && expectedSaveText != actualSaveText {
      return false
    }
    return true
  }

  func fetchText() {
    didCallFetchText = true
  }

  func save(text: String) {
    actualSaveText = text
  }
}
