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
    let listViewNotes: [ListViewNote] = notes.map {
      let summaryText = summary(for: $0.text)
      return ListViewNote(id: $0.id, summary: summaryText)
    }
    interface.update(notes: listViewNotes)
  }

  func summary(for text: String) -> String {
    if "" ==  text {
      return "<empty>"
    }
    return text
  }
}
