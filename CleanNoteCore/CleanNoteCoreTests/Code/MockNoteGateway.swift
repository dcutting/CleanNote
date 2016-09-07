import CleanNoteCore

class MockNoteGateway: NoteGateway {
  var noteIDForSaveNote: NoteID?
  var textForSaveNote: String?
  var shouldThrowSaveError: NoteGatewayError?
  var shouldThrowCreateNoteError: NoteGatewayError?
  var spiedFetchNotes: AsyncThrowable<[Note]>?
  var spiedFetchNoteWithID: (NoteID, AsyncThrowable<Note>)?

  func fetchNotes(completion: AsyncThrowable<[Note]>) {
    spiedFetchNotes = completion
  }

  func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>) {
    spiedFetchNoteWithID = (id, completion)
  }

  func makeNote(completion: AsyncThrowable<Note>) {
  }

  func save(text: String, for id: NoteID, completion: AsyncThrowable<Void>) {
  }

//  func createNote() throws -> Note {
//    if let error = shouldThrowCreateNoteError {
//      throw error
//    }
//    return Note(id: NoteID(), text: "")
//  }
//
//  func save(text: String, for noteID: NoteID) throws {
//    if let error = shouldThrowSaveError {
//      throw error
//    }
//    noteIDForSaveNote = noteID
//    textForSaveNote = text
//  }

  func stub(saveThrows error: NoteGatewayError) {
    shouldThrowSaveError = error
  }

  func stub(createNoteThrows error: NoteGatewayError) {
    shouldThrowCreateNoteError = error
  }
}
