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
    let listViewNotes = notes.map {
      return ListViewNote(id: $0.id, summary: $0.text)
    }
    interface.update(notes: listViewNotes)
  }
}
