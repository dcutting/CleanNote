@testable import CleanNote

class MockNoteGateway: NoteGateway {
  var textForCreateNote: String?
  var noteIDForSaveNote: NoteID?
  var textForSaveNote: String?
  var shouldThrowError: NoteGatewayError?

  func fetchNotes(completion: ([Note]) -> Void) {
  }

  func fetchNote(with id: NoteID, completion: (Note?) -> Void) {
  }

  func createNote(with text: String) -> NoteID {
    textForCreateNote = text
    return ""
  }

  func save(text: String, for noteID: NoteID) throws {
    if let error = shouldThrowError {
      throw error
    }
    noteIDForSaveNote = noteID
    textForSaveNote = text
  }

  func stub(saveThrows error: NoteGatewayError) {
    shouldThrowError = error
  }
}
