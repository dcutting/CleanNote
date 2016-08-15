import Cocoa
import CleanNoteCore

protocol ListViewControllerDelegate: class {
  func didSelect(noteID: NoteID)
  func didDeselectAllNotes()
}

class ListViewController: NSViewController {
  var list: ListViewList?
  var currentlySelectedRow: Int?
  weak var delegate: ListViewControllerDelegate?
  @IBOutlet weak var tableView: NSTableView!
}

extension ListViewController: ListInterface {
  func update(list: ListViewList) {
    self.list = list
    tableView.reloadData()
    if let row = list.selectedRow {
      select(row: row)
    } else {
      deselectAllRows()
    }
  }

  private func select(row: Int) {
    let rowIndexes = IndexSet(integer: row)
    tableView.selectRowIndexes(rowIndexes, byExtendingSelection: false)
    tableView.scrollRowToVisible(row)
  }

  private func deselectAllRows() {
    tableView.deselectAll(nil)
  }

  func show(error: String) {
    // TODO - show error
  }
}

extension ListViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    guard let notes = list?.notes else { return 0 }
    return notes.count
  }
}

extension ListViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
    guard let notes = list?.notes else { return cellView }
    guard let label = cellView.textField else { return cellView }
    let listViewNote = notes[row]
    label.stringValue = listViewNote.summary
    return cellView
  }

  func tableViewSelectionDidChange(_ notification: Notification) {
    if let row = selectedRow() {
      notifyDelegateOfSelection(row: row)
    } else {
      notifyDelegateOfDeselection()
    }
  }

  private func selectedRow() -> Int? {
    let row = tableView.selectedRow
    return -1 == row ? nil : row
  }

  private func notifyDelegateOfSelection(row: Int) {
    guard currentlySelectedRow != row else { return }
    currentlySelectedRow = row
    guard let noteID = list?.notes[row].id else { return }
    delegate?.didSelect(noteID: noteID)
  }

  private func notifyDelegateOfDeselection() {
    guard currentlySelectedRow != nil else { return }
    currentlySelectedRow = nil
    delegate?.didDeselectAllNotes()
  }
}
