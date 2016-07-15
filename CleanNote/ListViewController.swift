import UIKit

class ListViewController: UIViewController, ListInterface, UITableViewDataSource, UITableViewDelegate {
  var interactor: ListInteractorInput!
  var listViewNotes = [ListViewNote]()
  @IBOutlet weak var tableView: UITableView!

  override func viewDidAppear(_ animated: Bool) {
    interactor.fetchNotes()
  }

  func update(notes: [ListViewNote]) {
    listViewNotes = notes
    tableView.reloadData()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection: NSInteger) -> NSInteger {
    return listViewNotes.count;
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")!
    cell.textLabel?.text = listViewNotes[indexPath.row].summary
    return cell
  }
}
