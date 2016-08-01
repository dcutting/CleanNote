import Cocoa
import CleanNoteCore

class ListViewControllerMac: NSViewController, ListInterface, NSTableViewDataSource, NSTableViewDelegate {
  
  @IBOutlet weak var tableView: NSTableView!
  weak var editorContainer: NSViewController!

  var interactor: ListInteractorInput!
  var listNotes = [ListViewNote]()

  func start() {
    interactor.fetchNotes()
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  override func prepare(for segue: NSStoryboardSegue, sender: AnyObject?) {
    let editorViewController = segue.destinationController as! EditorViewControllerMac
    if "editNote" == segue.identifier {
      prepareForEditSegue(to: editorViewController)
    }
  }

  private func prepareForEditSegue(to editorViewController: EditorViewControllerMac) {
    if let noteID = noteIDForSelectedRow() {
      print("configuring editor with \(noteID)")
    } else {
      print("configuring editor with no note")
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
