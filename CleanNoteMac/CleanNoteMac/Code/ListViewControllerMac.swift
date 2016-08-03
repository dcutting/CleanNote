import Cocoa
import CleanNoteCore

protocol ListViewControllerMacDelegate: class {
  func didSelect(noteID: NoteID)
  func didDeselectAllNotes()
}

class ListViewControllerMac: NSViewController, ListInterface, NSTableViewDataSource, NSTableViewDelegate {

  @IBOutlet weak var tableView: NSTableView!
  weak var delegate: ListViewControllerMacDelegate?
  var listNotes = [ListViewNote]()

  func update(notes: [ListViewNote]) {
    listNotes = notes
//    let selectedRowIndexes = tableView.selectedRowIndexes
    tableView.reloadData()
//    tableView.selectRowIndexes(selectedRowIndexes, byExtendingSelection: false)
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

  func tableViewSelectionDidChange(_ notification: Notification) {
    if let noteID = noteIDForSelectedRow() {
      delegate?.didSelect(noteID: noteID)
    } else {
      delegate?.didDeselectAllNotes()
    }
  }

  private func noteIDForSelectedRow() -> NoteID? {
    let row = tableView.selectedRow
    return -1 == row ? nil : listNotes[row].id
  }
}
