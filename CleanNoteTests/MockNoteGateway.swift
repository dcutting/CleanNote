@testable import CleanNote

class MockNoteGateway: NoteGateway {
  var textForCreateNote: String?

  func fetchNotes(completion: ([Note]) -> Void) {
  }

  func fetchNote(with id: NoteID, completion: (Note?) -> Void) {
  }

  func createNote(with text: String) {
    textForCreateNote = text
  }

  func save(text: String, for noteID: NoteID) {
  }
}
