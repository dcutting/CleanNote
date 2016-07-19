@testable import CleanNote

class MockEditorInteractorInput: EditorInteractorInput {
  var shouldExpectFetchText = false
  var didCallFetchText = false
  var expectedSaveText: String?
  var actualSaveText: String?

  func expectFetchText() {
    shouldExpectFetchText = true
  }

  func expectSave(text: String) {
    expectedSaveText = text
  }

  func assert() -> Bool {
    if shouldExpectFetchText {
      if !didCallFetchText {
        return false
      }
    }
    if let expectedSaveText = expectedSaveText {
      if expectedSaveText != actualSaveText {
        return false
      }
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
