public typealias NoteID = String

public struct Note {
  var id: NoteID
  var text: String

  public init(id: NoteID, text: String) {
    self.id = id
    self.text = text
  }
}

extension Note: Equatable {}

public func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.id == rhs.id && lhs.text == rhs.text
}
