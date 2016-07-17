class ListWireframe {
  func configure(listViewController: ListViewController, noteService: NoteService, editorWireframe: EditorWireframe) {
    let listPresenter = ListPresenter(interface: listViewController)
    let listInteractor = ListInteractor(output: listPresenter, service: noteService)
    listViewController.interactor = listInteractor
    listViewController.editorWireframe = editorWireframe
  }
}
