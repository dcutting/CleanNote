import UIKit
import CleanNoteCore

let EditNoteSegueIdentifier = "editNote"

class NoteIDWrapperObject: NSObject {
  let id: NoteID

  init(id: NoteID) {
    self.id = id
  }
}

class ListViewController: StoryboardViewController {
  var interactor: ListInteractorInput!
  var editorWireframe: EditorWireframe!
  var list: ListViewList?
  @IBOutlet weak var tableView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    interactor.fetchNotesAndSelect(noteID: nil)
  }

  fileprivate func noteIDFor(row: Int) -> NoteID? {
    guard let listViewNote = list?.notes[row] else { return nil }
    return listViewNote.id
  }

  @IBAction func addNote(_ sender: AnyObject) {
    interactor.makeNote()
  }
    
}

extension ListViewController: ListInterface {
  func update(list: ListViewList) {
    self.list = list
    updateData()
    updateSelection()
  }

  private func updateData() {
    tableView.reloadData()
  }

  private func updateSelection() {
    guard let row = rowForSelectedNote() else { return }
    select(row: row)
  }

  private func rowForSelectedNote() -> Int? {
    return list?.notes.index { $0.id == list?.selected }
  }

  private func select(row: Int) {
    scrollTo(row: row)
    segueToNote(at: row)
  }

  private func scrollTo(row: Int) {
    let indexPath = IndexPath(row: row, section: 0)
    tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
  }

  private func segueToNote(at row: Int) {
    guard let noteID = noteIDFor(row: row) else { return }
    let noteIDWrapperObject = NoteIDWrapperObject(id: noteID)
    performSegue(withIdentifier: EditNoteSegueIdentifier, sender: noteIDWrapperObject)
  }

  func present(error: RetryableError<ListError>) {
    guard let controller = navigationController else { return }
    AlertHelper().show(title: "Error", text: error.localizedDescription, controller: controller)
  }
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection: NSInteger) -> NSInteger {
    return list?.notes.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")!
    cell.textLabel?.text = list?.notes[indexPath.row].summary
    return cell
  }
}
