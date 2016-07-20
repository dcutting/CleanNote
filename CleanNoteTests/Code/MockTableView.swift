import UIKit

class MockTableView: UITableView {
  var shouldReloadData = false
  var didCallReloadData = false
  var cell: UITableViewCell?
  var identifier: String?
  var indexPath: IndexPath?
  var selectedRow: Int?

  func stub(dequeueReusableCell cell: UITableViewCell, with identifier: String) {
    self.cell = cell
    self.identifier = identifier
  }

  func stub(indexPath: IndexPath, forSelectedRow row: Int) {
    self.indexPath = indexPath
    self.selectedRow = row
  }

  override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
    return identifier == self.identifier ? cell : nil
  }

  override var indexPathForSelectedRow: IndexPath? {
    get {
      return indexPath
    }
  }

  func expectReloadData() {
    shouldReloadData = true
  }

  override func reloadData() {
    didCallReloadData = true
  }

  func assert() -> Bool {
    if shouldReloadData && !didCallReloadData {
      return false
    }
    return true
  }
}
