class MockListInteractorInput: ListInteractorInput {

  var spiedFetchNotesAndSelectNoteID: NoteID??

  func fetchNotesAndSelect(noteID: NoteID?) {
    spiedFetchNotesAndSelectNoteID = noteID
  }

  func makeNote() {
  }
    
}
