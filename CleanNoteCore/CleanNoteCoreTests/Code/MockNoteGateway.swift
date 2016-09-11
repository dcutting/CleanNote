import CleanNoteCore

class MockNoteGateway: NoteGateway {
  var shouldThrowFetchNotesError: NoteGatewayError?
  var stubFetchNotes: [Note]?
  var spiedFetchNotes: AsyncThrowable<[Note]>?

  var shouldThrowFetchNoteWithIDError: NoteGatewayError?
  var spiedFetchNoteWithID: (NoteID, AsyncThrowable<Note>)?

  var shouldThrowMakeNoteError: NoteGatewayError?
  var stubMakeNote: Note?
  var spiedMakeNotes: AsyncThrowable<Note>?

  var spiedSaveTextForNoteID: (String, NoteID, AsyncThrowable<Void>)?

  func fetchNotes(completion: @escaping AsyncThrowable<[Note]>) {
    spiedFetchNotes = completion
    if let error = shouldThrowFetchNotesError {
      completion { throw error }
    } else if let notes = stubFetchNotes {
      completion { return notes }
    }
  }

  func fetchNote(with id: NoteID, completion: @escaping AsyncThrowable<Note>) {
    spiedFetchNoteWithID = (id, completion)
    if let error = shouldThrowFetchNoteWithIDError {
      completion { throw error }
    }
  }

  func makeNote(completion: @escaping AsyncThrowable<Note>) {
    spiedMakeNotes = completion
    if let error = shouldThrowMakeNoteError {
      completion { throw error }
    } else if let note = stubMakeNote {
      completion { return note }
    }
  }

  func save(text: String, for id: NoteID, completion: @escaping AsyncThrowable<Void>) {
    spiedSaveTextForNoteID = (text, id, completion)
  }

  func stub(fetchNotes notes: [Note]) {
    stubFetchNotes = notes
  }

  func stub(makeNote note: Note) {
    stubMakeNote = note
  }

  func stub(fetchNotesThrows error: NoteGatewayError) {
    shouldThrowFetchNotesError = error
  }

  func stub(fetchNoteWithIDThrows error: NoteGatewayError) {
    shouldThrowFetchNoteWithIDError = error
  }

  func stub(makeNoteThrows error: NoteGatewayError) {
    shouldThrowMakeNoteError = error
  }
}
