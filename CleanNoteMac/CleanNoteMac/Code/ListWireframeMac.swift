import Cocoa
import CleanNoteCore

class ListWireframeMac {
  func configure(listViewController: ListViewControllerMac, editorWireframe: EditorWireframeMac, editorContainer: NSViewController, noteGateway: NoteGateway) {
    let listPresenter = ListPresenter(interface: listViewController)
    let listInteractor = ListInteractor(output: listPresenter, gateway: noteGateway)
    listViewController.interactor = listInteractor
    listViewController.editorWireframe = editorWireframe
    listViewController.editorContainer = editorContainer
  }
}
