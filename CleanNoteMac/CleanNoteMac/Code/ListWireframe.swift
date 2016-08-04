import CleanNoteCore

class ListWireframe {
  let noteGateway: NoteGateway

  init(noteGateway: NoteGateway) {
    self.noteGateway = noteGateway
  }
  
  func configure(listViewController: ListViewController) -> ListInteractor {
    let listPresenter = ListPresenter(interface: listViewController)
    let listInteractor = ListInteractor(output: listPresenter, gateway: noteGateway)
    return listInteractor
  }
}
