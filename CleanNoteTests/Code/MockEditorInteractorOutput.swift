@testable import CleanNote

class MockEditorInteractorOutput: EditorInteractorOutput {
  var actualText: String?

  func didFetch(text: String) {
    actualText = text
  }
}
