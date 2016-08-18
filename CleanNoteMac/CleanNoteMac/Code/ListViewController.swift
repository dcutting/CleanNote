import Cocoa
import CleanNoteCore

protocol ListViewControllerDelegate: class {
  func didSelect(noteID: NoteID)
  func didDeselectAllNotes()
}

class ListViewController: NSViewController {
  var list: ListViewList?
  weak var delegate: ListViewControllerDelegate?
  @IBOutlet weak var tableView: NSTableView!
  var shouldNotifyDelegate = true
}

extension ListViewController: ListInterface {
  func update(list nextList: ListViewList) {
    prepareShouldNotifyDelegate(previousSelection: self.list?.selected, nextSelection: nextList.selected)

    self.list = nextList

    updateTableData()
    updateTableSelection()

    resetShouldNotifyDelegate()
  }

  private func prepareShouldNotifyDelegate(previousSelection: NoteID?, nextSelection: NoteID?) {
    shouldNotifyDelegate = previousSelection != nextSelection
  }

  private func updateTableData() {
    tableView.reloadData()
  }

  private func updateTableSelection() {
    if let noteID = list?.selected {
      select(noteID: noteID)
    } else {
      deselectAll()
    }
  }

  private func select(noteID: NoteID) {
    guard let row = rowFor(noteID: noteID, in: list?.notes) else { return }
    let rowIndexes = IndexSet(integer: row)
    tableView.selectRowIndexes(rowIndexes, byExtendingSelection: false)
    tableView.scrollRowToVisible(row)
  }

  private func rowFor(noteID: NoteID?, in notes: [ListViewNote]?) -> Int? {
    guard let notes = notes else { return nil }
    guard let noteID = noteID else { return nil }
    return notes.index { $0.id == noteID }
  }

  private func deselectAll() {
    tableView.deselectAll(nil)
  }

  private func resetShouldNotifyDelegate() {
    shouldNotifyDelegate = true
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
    guard shouldNotifyDelegate else { return }
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
    guard let noteID = list?.notes[row].id else { return }
    delegate?.didSelect(noteID: noteID)
  }

  private func notifyDelegateOfDeselection() {
    delegate?.didDeselectAllNotes()
  }
}
