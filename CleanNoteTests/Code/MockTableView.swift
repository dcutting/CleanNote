import UIKit

class MockTableView: UITableView {
  var shouldReloadData = false
  var didCallReloadData = false
  var cell: UITableViewCell?
  var identifier: String?

  func stub(dequeueReusableCell cell: UITableViewCell, with identifier: String) {
    self.cell = cell
    self.identifier = identifier
  }

  override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
    return identifier == self.identifier ? cell : nil
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
