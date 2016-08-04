class MockEditorInterface: EditorInterface {
  var actualUpdateText: String?
  var shouldExpectError = false
  var didCallError = false

  func expectError() {
    shouldExpectError = true
  }

  func update(text: String) {
    actualUpdateText = text
  }

  func show(error: String) {
    didCallError = true
  }

  func assert() -> Bool {
    return shouldExpectError && didCallError
  }
}
