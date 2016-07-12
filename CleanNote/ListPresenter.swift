struct ListViewNote {
  var summary: String
}

protocol ListViewInterface {
  func update(notes: [ListViewNote])
}

class ListPresenter: ListInteractorOutput {
  var interface: ListViewInterface

  init(interface: ListViewInterface) {
    self.interface = interface
  }

  func didFetch(notes: [Note]) {
    let listNotes = notes.map {
      return ListViewNote(summary: $0.text)
    }
    interface.update(notes: listNotes)
  }
}
