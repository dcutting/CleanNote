import Cocoa
import CleanNoteCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let controller = getWindowController()

    let splitViewController = controller.contentViewController as! NSSplitViewController
    let listViewController = splitViewController.childViewControllers[0] as! ListViewControllerMac
    let editorContainer = splitViewController.childViewControllers[1]

    RootWireframe().configure(listViewController: listViewController, editorContainer: editorContainer)

    configure(splitViewController: splitViewController)

    listViewController.start()
  }

  func getWindowController() -> NSWindowController {
    let window = NSApplication.shared().windows[0] as NSWindow
    return window.windowController!
  }

  func configure(splitViewController: NSSplitViewController) {
    splitViewController.view.wantsLayer = true  // To enable round window corners.
  }
}
