import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection: NSInteger) -> NSInteger {
        return 10;
    }

    func tableView(_ tableView: UITableView, cellForRowAt cellForRowAtIndexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")
        cell?.textLabel?.text = "hello"
        return cell!
    }
}
