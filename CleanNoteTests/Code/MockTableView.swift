import UIKit

class MockTableView: UITableView {
  var cell: UITableViewCell?
  var identifier: String?

  func stub(dequeueReusableCell cell: UITableViewCell, with identifier: String) {
    self.cell = cell
    self.identifier = identifier
  }

  override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
    return identifier == self.identifier ? cell : nil
  }
}
