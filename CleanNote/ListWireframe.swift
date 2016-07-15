class ListWireframe {
  func configure(listViewController: ListViewController, noteService: NoteService) {
    let listPresenter = ListPresenter(interface: listViewController)
    let listInteractor = ListInteractor(output: listPresenter, service: noteService)
    listViewController.interactor = listInteractor
  }
}
