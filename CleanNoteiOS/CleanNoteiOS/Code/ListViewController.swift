import UIKit
import CleanNoteCore

class ListViewController: UIViewController, ListInterface, UITableViewDataSource, UITableViewDelegate {
  var noteGateway: NoteGateway!
  var interactor: ListInteractorInput!
  var editorWireframe: EditorWireframe!
  var listNotes = [ListViewNote]()
  @IBOutlet weak var tableView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    interactor.fetchNotes()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    let editorViewController = segue.destination as! EditorViewController
    if "editNote" == segue.identifier {
      prepareForEditSegue(to: editorViewController)
    } else if "addNote" == segue.identifier {
      prepareForAddSegue(to: editorViewController)
    }
  }

  private func prepareForEditSegue(to editorViewController: EditorViewController) {
    let noteID = noteIDForSelectedRow()
    editorWireframe.configure(editorViewController: editorViewController, noteID: noteID)
  }

  private func noteIDForSelectedRow() -> NoteID {
    let indexPath = tableView.indexPathForSelectedRow!
    let listViewNote = listNotes[indexPath.row]
    return listViewNote.id
  }

  private func prepareForAddSegue(to editorViewController: EditorViewController) {
    do {
      let note = try noteGateway.createNote()
      editorWireframe.configure(editorViewController: editorViewController, noteID: note.id)
    } catch {
      // TODO
    }
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  func update(note: ListViewNote) {
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
