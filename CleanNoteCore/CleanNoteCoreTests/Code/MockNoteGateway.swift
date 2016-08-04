class MockNoteGateway: NoteGateway {
  var noteIDForSaveNote: NoteID?
  var textForSaveNote: String?
  var shouldThrowSaveError: NoteGatewayError?
  var shouldThrowCreateNoteError: NoteGatewayError?

  func fetchNotes(completion: ([Note]) -> Void) {
  }

  func fetchNote(with id: NoteID, completion: (Note) -> Void) throws {
  }

  func createNote() throws -> NoteID {
    if let error = shouldThrowCreateNoteError {
      throw error
    }
    return NoteID()
  }

  func save(text: String, for noteID: NoteID) throws {
    if let error = shouldThrowSaveError {
      throw error
    }
    noteIDForSaveNote = noteID
    textForSaveNote = text
  }

  func stub(saveThrows error: NoteGatewayError) {
    shouldThrowSaveError = error
  }

  func stub(createNoteThrows error: NoteGatewayError) {
    shouldThrowCreateNoteError = error
  }
}
