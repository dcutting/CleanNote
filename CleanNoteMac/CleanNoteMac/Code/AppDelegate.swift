import Cocoa
import CleanNoteCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let notesViewController = getNotesViewController()
    NotesWireframe().configure(notesViewController: notesViewController)
    notesViewController.start()
  }

  private func getNotesViewController() -> NotesViewController {
    let window = NSApplication.shared().windows[0] as NSWindow
    let windowController = window.windowController!
    let notesViewController = windowController.contentViewController as! NotesViewController
    return notesViewController
  }
}
