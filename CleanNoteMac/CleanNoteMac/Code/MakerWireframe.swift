import Cocoa
import CleanNoteCore

class MakerWireframe {
  func configure(notesViewController: NotesViewController, noteGateway: NoteGateway) -> MakerInteractor {

    let makerPresenter = MakerPresenter(interface: notesViewController)
    let makerInteractor = MakerInteractor(output: makerPresenter, noteGateway: noteGateway)

    return makerInteractor
  }
}
