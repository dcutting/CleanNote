@testable import CleanNote

class MockEditorInterface: EditorInterface {
  var actualText: String?

  func update(text: String) {
    actualText = text
  }
}
