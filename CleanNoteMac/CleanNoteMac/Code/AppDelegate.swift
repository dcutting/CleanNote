import Cocoa
import CleanNoteCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let (_, controller) = getWindowAndController()
    let splitController = controller.contentViewController as! NSSplitViewController
    let listViewController = splitController.childViewControllers[0] as! ListViewControllerMac
    let editorContainer = splitController.childViewControllers[1]

    RootWireframe().configure(listViewController: listViewController, editorContainer: editorContainer)

    listViewController.start()
  }

  func getWindowAndController() -> (NSWindow, NSWindowController) {
    let window = NSApplication.shared().windows[0] as NSWindow
    let controller = window.windowController!
    return (window, controller)
  }
}
