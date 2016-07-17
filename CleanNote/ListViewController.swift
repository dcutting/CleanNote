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
    if "editNote" == segue.identifier {
      prepare(forEdit: segue)
    }
  }

  func prepare(forEdit segue: UIStoryboardSegue) {
    guard let editorViewController = segue.destinationViewController as? EditorViewController else { return }
    guard let noteID = noteIDForSelectedRow() else { return }
    editorWireframe.configure(editorViewController: editorViewController, noteID: noteID)
  }

  func noteIDForSelectedRow() -> NoteID? {
    guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
    let listViewNote = listNotes[indexPath.row]
    return listViewNote.id
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
