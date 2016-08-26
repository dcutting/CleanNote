public enum NoteGatewayError: Error {
  case notFound
  case unknown
}

public typealias AsyncThrowable<T> = ((Void) throws -> T) -> Void

public protocol NoteGateway {
  func fetchNotes(completion: AsyncThrowable<[Note]>)
  func fetchNote(with id: NoteID, completion: AsyncThrowable<Note>)
  func makeNote(completion: AsyncThrowable<Note>)
  func save(text: String, for id: NoteID, completion: AsyncThrowable<Void>)
}
