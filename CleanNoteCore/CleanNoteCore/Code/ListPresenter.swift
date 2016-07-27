struct ListViewNote {
  let id: NoteID
  var summary: String
}

extension ListViewNote: Equatable {}

func ==(lhs: ListViewNote, rhs: ListViewNote) -> Bool {
  return lhs.id == rhs.id && lhs.summary == rhs.summary
}

protocol ListInterface {
  func update(notes: [ListViewNote])
}

class ListPresenter: ListInteractorOutput {
  let interface: ListInterface

  init(interface: ListInterface) {
    self.interface = interface
  }

  func didFetch(notes: [Note]) {
    let listViewNotes = notes.map(makeListViewNote)
    interface.update(notes: listViewNotes)
  }

  private func makeListViewNote(for note: Note) -> ListViewNote {
    let summaryText = summary(for: note.text)
    return ListViewNote(id: note.id, summary: summaryText)
  }

  private func summary(for text: String) -> String {
    if text.isEmpty { return "<empty>" }
    return nonEmptySummary(for: text)
  }

  private func nonEmptySummary(for text: String) -> String {
    return text// text.replacingOccurrences(of: "\n", with: " ")
  }
}
