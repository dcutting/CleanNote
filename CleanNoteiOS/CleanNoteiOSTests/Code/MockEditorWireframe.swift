import UIKit
@testable import CleanNote

class MockEditorWireframe: EditorWireframe {
  var expectConfiguration = false
  var expectedEditorViewController: UIViewController?
  var expectedNoteID: NoteID?
  var configuredEditorViewController: UIViewController?
  var configuredNoteID: NoteID?

  func expect(configureEditorViewController editorViewController: UIViewController, noteID: NoteID?) {
    expectConfiguration = true
    expectedEditorViewController = editorViewController
    expectedNoteID = noteID
  }

  override func configure(editorViewController: EditorViewController, noteID: NoteID?) {
    configuredEditorViewController = editorViewController
    configuredNoteID = noteID
  }

  func assert() -> Bool {
    if expectConfiguration {
      let viewControllerMatches = expectedEditorViewController == configuredEditorViewController
      let noteIDMatches = expectedNoteID == configuredNoteID
      return viewControllerMatches && noteIDMatches
    }
    return true
  }
}
