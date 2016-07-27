typealias NoteID = String

struct Note {
  var id: NoteID
  var text: String
}

extension Note: Equatable {}

func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.id == rhs.id && lhs.text == rhs.text
}
