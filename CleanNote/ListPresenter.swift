struct ListNote {
  var summary: String
}

protocol ListInterface {
  func update(notes: [ListNote])
}

class ListPresenter: ListInteractorOutput {
  let interface: ListInterface

  init(interface: ListInterface) {
    self.interface = interface
  }

  func didFetch(notes: [Note]) {
    let listNotes = notes.map {
      return ListNote(summary: $0.text)
    }
    interface.update(notes: listNotes)
  }
}
