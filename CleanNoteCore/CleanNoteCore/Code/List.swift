public struct List {
  let notes: [Note]
  let selected: NoteID?
}

extension List: Equatable {}

public func ==(lhs: List, rhs: List) -> Bool {
  return lhs.notes == rhs.notes && lhs.selected == rhs.selected
}
