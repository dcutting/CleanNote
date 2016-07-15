import UIKit

class ListViewController: UIViewController, ListInterface, UITableViewDataSource, UITableViewDelegate {
  var interactor: ListInteractorInput!
  var listNotes = [ListNote]()
  @IBOutlet weak var tableView: UITableView!

  override func viewDidAppear(_ animated: Bool) {
    interactor.fetchNotes()
  }

  func update(notes: [ListNote]) {
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
