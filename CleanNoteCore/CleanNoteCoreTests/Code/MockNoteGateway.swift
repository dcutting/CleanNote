import CleanNoteCore

class MockNoteGateway: NoteGateway {
//  var noteIDForSaveNote: NoteID?
//  var textForSaveNote: String?
  var stubFetchNotes: [Note]?
  var stubMakeNote: Note?
  var shouldThrowFetchNotes: NoteGatewayError?
  var shouldThrowSaveError: NoteGatewayError?
  var shouldThrowCreateNoteError: NoteGatewayError?
  var spiedFetchNotes: AsyncThrowable<[Note]>?
  var spiedFetchNoteWithID: (NoteID, AsyncThrowable<Note>)?
  var spiedMakeNotes: AsyncThrowable<Note>?
  var spiedSaveTextForNoteID: (String, NoteID, AsyncThrowable<Void>)?

  func fetchNotes(completion: AsyncThrowable<[Note]>) {
    spiedFetchNotes = completion
    if let error = shouldThrowFetchNotes {
      completion { throw error }
    } else if let notes = stubFetchNotes {
      completion { return notes }
    }
  }

  func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>) {
    spiedFetchNoteWithID = (id, completion)
  }

  func makeNote(completion: AsyncThrowable<Note>) {
    spiedMakeNotes = completion
    if let note = stubMakeNote {
      completion { return note }
    }
  }

  func save(text: String, for id: NoteID, completion: AsyncThrowable<Void>) {
    spiedSaveTextForNoteID = (text, id, completion)
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

  func stub(fetchNotes notes: [Note]) {
    stubFetchNotes = notes
  }

  func stub(makeNote note: Note) {
    stubMakeNote = note
  }

  func stub(fetchNotesThrows error: NoteGatewayError) {
    shouldThrowFetchNotes = error
  }

  func stub(saveThrows error: NoteGatewayError) {
    shouldThrowSaveError = error
  }

  func stub(createNoteThrows error: NoteGatewayError) {
    shouldThrowCreateNoteError = error
  }
}
