@testable import CleanNote

class MockEditorInteractorInput: EditorInteractorInput {
  var shouldExpectFetchText = false
  var didCallFetchText = false

  func expectFetchText() {
    shouldExpectFetchText = true
  }

  func assert() -> Bool {
    if shouldExpectFetchText {
      return didCallFetchText
    }
    return true
  }

  func fetchText() {
    didCallFetchText = true
  }

  func save(text: String) {
  }
}
