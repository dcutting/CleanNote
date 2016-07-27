enum NoteGatewayError: ErrorProtocol {
  case notFound
  case unknown
}

protocol NoteGateway {
  func fetchNotes(completion: ([Note]) -> Void)
  func fetchNote(with id: NoteID, completion: (Note?) -> Void)
  func createNote(with text: String) throws -> NoteID
  func save(text: String, for noteID: NoteID) throws
}
