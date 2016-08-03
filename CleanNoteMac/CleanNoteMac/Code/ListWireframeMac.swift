import Cocoa
import CleanNoteCore

class ListWireframeMac {
  let noteGateway: NoteGateway

  init(noteGateway: NoteGateway) {
    self.noteGateway = noteGateway
  }
  
  func configure(listViewController: ListViewControllerMac) -> ListInteractor {
    let listPresenter = ListPresenter(interface: listViewController)
    let listInteractor = ListInteractor(output: listPresenter, gateway: noteGateway)
    return listInteractor
  }
}
