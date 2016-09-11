public enum NoteGatewayError: Error {
  case notFound
  case unknown
}

public typealias AsyncThrowable<T> = ((Void) throws -> T) -> Void

public protocol NoteGateway {
  func fetchNotes(completion: @escaping AsyncThrowable<[Note]>)
  func fetchNote(with id: NoteID, completion: @escaping AsyncThrowable<Note>)
  func makeNote(completion: @escaping AsyncThrowable<Note>)
  func save(text: String, for id: NoteID, completion: @escaping AsyncThrowable<Void>)
}
