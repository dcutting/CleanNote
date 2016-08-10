import Cocoa
import CleanNoteCore

protocol ListViewControllerDelegate: class {
  func didSelect(noteID: NoteID)
  func didDeselectAllNotes()
}

class ListViewController: NSViewController {
  var listNotes = [ListViewNote]()
  weak var delegate: ListViewControllerDelegate?
  @IBOutlet weak var tableView: NSTableView!
}

extension ListViewController: ListInterface {
  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  func select(row: Int) {
    let rowIndexes = IndexSet(integer: row)
    tableView.selectRowIndexes(rowIndexes, byExtendingSelection: false)
    tableView.scrollRowToVisible(row)
  }

  func deselectAllRows() {
    tableView.deselectAll(nil)
  }

  func show(error: String) {
    // TODO - show error
  }
}

extension ListViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return listNotes.count
  }
}

extension ListViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
    if let label = cellView.textField {
      let listViewNote = listNotes[row]
      label.stringValue = listViewNote.summary
    }
    return cellView
  }

  func tableViewSelectionDidChange(_ notification: Notification) {
    if let row = selectedRow() {
      let noteID = listNotes[row].id
      delegate?.didSelect(noteID: noteID)
    } else {
      delegate?.didDeselectAllNotes()
    }
  }

  private func selectedRow() -> Int? {
    let row = tableView.selectedRow
    return -1 == row ? nil : row
  }
}
