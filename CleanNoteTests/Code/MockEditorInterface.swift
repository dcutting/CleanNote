@testable import CleanNote

class MockEditorInterface: EditorInterface {
  var actualUpdateText: String?
  var actualErrorText: String?

  func update(text: String) {
    actualUpdateText = text
  }

  func error(text: String) {
    actualErrorText = text
  }
}
