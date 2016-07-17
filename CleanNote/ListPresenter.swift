struct ListViewNote {
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
      return ListViewNote(summary: $0.text)
    }
    interface.update(notes: listViewNotes)
  }
}
