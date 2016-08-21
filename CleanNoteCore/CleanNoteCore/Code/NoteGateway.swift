public enum NoteGatewayError: Error {
  case notFound
  case unknown
}

public protocol NoteGateway {
  func fetchNotes(completion: ([Note]) -> Void)
  func fetchNote(with id: NoteID, completion: ((Void) throws -> Note) -> Void)
  func makeNote() throws -> Note
  func save(text: String, for id: NoteID) throws
}
