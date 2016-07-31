import Cocoa

class ListViewControllerMac: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
  
  @IBOutlet weak var tableView: NSTableView!

  func numberOfRows(in tableView: NSTableView) -> Int {
    return 3
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView

    if let label = cellView.textField {
      label.stringValue = "Hello"
    }

    return cellView
  }
}
