import Cocoa
import CleanNoteCore

class ListViewControllerMac: NSViewController, ListInterface, NSTableViewDataSource, NSTableViewDelegate {

  var editorWireframe: EditorWireframeMac!
  @IBOutlet weak var tableView: NSTableView!
  weak var editorContainer: NSViewController!

  var interactor: ListInteractorInput!
  var listNotes = [ListViewNote]()

  func start() {
    showEmptyNote()
  }

  func showEmptyNote() {
    tableView.deselectAll(nil)
    performSegue(withIdentifier: "editNote", sender: nil)
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    let selectedRowIndexes = tableView.selectedRowIndexes
    tableView.reloadData()
    tableView.selectRowIndexes(selectedRowIndexes, byExtendingSelection: false)
  }

  override func prepare(for segue: NSStoryboardSegue, sender: AnyObject?) {
    let editorViewController = segue.destinationController as! EditorViewControllerMac
    if "editNote" == segue.identifier {
      prepareForEditSegue(to: editorViewController)
    }
    interactor.fetchNotes()
  }

  private func prepareForEditSegue(to editorViewController: EditorViewControllerMac) {
    if let noteID = noteIDForSelectedRow() {
      editorWireframe.configure(editorViewController: editorViewController, noteID: noteID)
    }
  }

  private func noteIDForSelectedRow() -> NoteID? {
    let row = tableView.selectedRow
    if -1 == row {
      return nil
    } else {
      return listNotes[row].id
    }
  }

  func numberOfRows(in tableView: NSTableView) -> Int {
    return listNotes.count
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView

    if let label = cellView.textField {
      let listViewNote = listNotes[row]
      label.stringValue = listViewNote.summary
    }

    return cellView
  }
}
