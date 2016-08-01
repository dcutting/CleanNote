import Cocoa
import CleanNoteCore

class ListViewControllerMac: NSViewController, ListInterface, NSTableViewDataSource, NSTableViewDelegate {
  
  @IBOutlet weak var tableView: NSTableView!

  var interactor: ListInteractorInput!
  var listNotes = [ListViewNote]()

  func start() {
    interactor.fetchNotes()
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
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
