import CleanNoteCore

class MakerWireframe {
  func configure(listViewController: ListViewController, noteGateway: NoteGateway) -> MakerInteractor {
    let makerPresenter = MakerPresenter(interface: listViewController)
    let makerInteractor = MakerInteractor(output: makerPresenter, noteGateway: noteGateway)
    return makerInteractor
  }
}
