import Cocoa
import CleanNoteCore

protocol ListViewControllerDelegate: class {
  func didSelect(noteID: NoteID)
  func didDeselectAllNotes()
}

class ListViewController: NSViewController, ListInterface, NSTableViewDataSource, NSTableViewDelegate {

  @IBOutlet weak var tableView: NSTableView!
  weak var delegate: ListViewControllerDelegate?

  var listNotes = [ListViewNote]()

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  public func select(row: Int) {
    let rowIndexes = IndexSet(integer: row)
    tableView.selectRowIndexes(rowIndexes, byExtendingSelection: false)
    tableView.scrollRowToVisible(row)
  }

  public func deselectAllRows() {
    tableView.deselectAll(nil)
  }

  public func show(error: String) {
    // TODO - show error
  }

//  private func reload(row: Int) {
//    let rowIndexes = IndexSet(integer: row)
//    let columnIndexes = IndexSet(integer: 0)
//    tableView.reloadData(forRowIndexes: rowIndexes, columnIndexes: columnIndexes)
//  }

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
