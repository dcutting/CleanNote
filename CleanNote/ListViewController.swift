import UIKit

class ListViewController: UIViewController, ListInterface, UITableViewDataSource, UITableViewDelegate {
  var interactor: ListInteractorInput!
  var listNotes = [ListViewNote]()
  @IBOutlet weak var tableView: UITableView!

  override func viewDidAppear(_ animated: Bool) {
    interactor.fetchNotes()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == "editNote" else { return }
    guard let editorViewController = segue.destinationViewController as? EditorViewController else { return }
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    let listViewNote = listNotes[indexPath.row]
    let noteID = listViewNote.id
    EditorWireframe().configure(editorViewController: editorViewController, noteService: NoteService(), noteID: noteID)
  }

  func update(notes: [ListViewNote]) {
    listNotes = notes
    tableView.reloadData()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection: NSInteger) -> NSInteger {
    return listNotes.count;
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")!
    cell.textLabel?.text = listNotes[indexPath.row].summary
    return cell
  }
}
