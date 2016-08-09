import UIKit
import CleanNoteCore

let EditNoteSegueIdentifier = "editNote"

class NoteIDObject: NSObject {
  let id: NoteID

  init(id: NoteID) {
    self.id = id
  }
}

class ListViewController: UIViewController {

  var interactor: ListInteractorInput!
  var editorWireframe: EditorWireframe!

  var listNotes = [ListViewNote]()

  @IBOutlet weak var tableView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    interactor.fetchNotesAndSelect(noteID: nil)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    guard EditNoteSegueIdentifier == segue.identifier else { return }
    let editorViewController = segue.destination as! EditorViewController
    let noteID = noteIDFrom(object: sender) ?? noteIDForSelectedRow()
    editorWireframe.configure(editorViewController: editorViewController, noteID: noteID)
  }

  private func noteIDFrom(object: AnyObject?) -> NoteID? {
    guard let noteIDObject = object as? NoteIDObject else { return nil }
    return noteIDObject.id
  }

  private func noteIDForSelectedRow() -> NoteID {
    let indexPath = tableView.indexPathForSelectedRow!
    let listViewNote = listNotes[indexPath.row]
    return listViewNote.id
  }

  @IBAction func addNote(_ sender: AnyObject) {
    interactor.makeNote()
  }
}

extension ListViewController: ListInterface {
  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  func select(row: Int) {
    let indexPath = IndexPath(row: row, section: 0)
    tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
  }

  func deselectAllRows() {
  }

  func show(error: String) {
    // TODO.
  }
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection: NSInteger) -> NSInteger {
    return listNotes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")!
    cell.textLabel?.text = listNotes[indexPath.row].summary
    return cell
  }
}
