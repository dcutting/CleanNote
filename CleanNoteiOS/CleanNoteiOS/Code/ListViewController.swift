import UIKit
import CleanNoteCore

let EditNoteSegueIdentifier = "editNote"

class NoteIDObject: NSObject {
  let id: NoteID

  init(id: NoteID) {
    self.id = id
  }
}

class ListViewController: UIViewController, ListInterface, MakerInterface, UITableViewDataSource, UITableViewDelegate {

  var listInteractor: ListInteractorInput!
  var makerInteractor: MakerInteractorInput!
  var editorWireframe: EditorWireframe!

  var listNotes = [ListViewNote]()

  @IBOutlet weak var tableView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    listInteractor.fetchNotes()
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
    makerInteractor.makeNote()
  }

  func didMake(note: Note) {
    let noteIDObject = NoteIDObject(id: note.id)
    performSegue(withIdentifier: EditNoteSegueIdentifier, sender: noteIDObject)
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  func update(note: ListViewNote) {
    guard let row = findRow(for: note) else { return }
    listNotes[row] = note
    reloadTableView(row: row)
  }

  private func findRow(for note: ListViewNote) -> Int? {
    return listNotes.index { $0.id == note.id }
  }

  private func reloadTableView(row: Int) {
    let rowIndexes = [IndexPath(row: row, section: 0)]
    tableView.reloadRows(at: rowIndexes, with: .automatic)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection: NSInteger) -> NSInteger {
    return listNotes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")!
    cell.textLabel?.text = listNotes[indexPath.row].summary
    return cell
  }
}
