import CleanNoteCore

class ListWireframe {
  func configure(listViewController: ListViewController, noteGateway: NoteGateway, editorWireframe: EditorWireframe) {

    let listPresenter = ListPresenter(interface: listViewController)
    let listInteractor = ListInteractor(output: listPresenter, gateway: noteGateway)

    let makerInteractor = MakerWireframe().configure(listViewController: listViewController, noteGateway: noteGateway)

    listViewController.listInteractor = listInteractor
    listViewController.makerInteractor = makerInteractor
    listViewController.editorWireframe = editorWireframe
  }
}
