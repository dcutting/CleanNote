import UIKit

class ListViewController: UIViewController, ListInterface, UITableViewDataSource, UITableViewDelegate {
  var interactor: ListInteractorInput!
  var editorWireframe: EditorWireframe!
  var listNotes = [ListViewNote]()
  @IBOutlet weak var tableView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    interactor.fetchNotes()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let editorViewController = segue.destinationViewController as? EditorViewController else { return }
    if "editNote" == segue.identifier {
      prepareForEditSegue(to: editorViewController)
    } else if "addNote" == segue.identifier {
      prepareForAddSegue(to: editorViewController)
    }
  }

  func prepareForEditSegue(to editorViewController: EditorViewController) {
    guard let noteID = noteIDForSelectedRow() else { return }
    editorWireframe.configure(editorViewController: editorViewController, noteID: noteID)
  }

  func noteIDForSelectedRow() -> NoteID? {
    guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
    let listViewNote = listNotes[indexPath.row]
    return listViewNote.id
  }

  func prepareForAddSegue(to editorViewController: EditorViewController) {
    editorWireframe.configure(editorViewController: editorViewController, noteID: nil)
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
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
