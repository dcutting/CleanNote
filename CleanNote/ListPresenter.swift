struct ListViewNote {
  let id: NoteID
  var summary: String
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

  func makeListViewNote(for note: Note) -> ListViewNote {
    let summaryText = summary(for: note.text)
    return ListViewNote(id: note.id, summary: summaryText)
  }

  func summary(for text: String) -> String {
    if "" == text {
      return "<empty>"
    }
    let trimIndex = text.index(text.startIndex, offsetBy: 100)
    return text.substring(to: trimIndex)
  }
}
