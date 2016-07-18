protocol NoteGateway {
  func fetchNotes(completion: ([Note]) -> Void)
  func fetchNote(with id: NoteID, completion: (Note?) -> Void)
  func createNote(with text: String)
  func save(text: String, for noteID: NoteID)
}
