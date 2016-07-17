import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let navController = window?.rootViewController as! UINavigationController
    let listViewController = navController.topViewController as! ListViewController

    configure(listViewController: listViewController)

    return true
  }

  func configure(listViewController: ListViewController) {
    let noteService = NoteService()

    let editorWireframe = EditorWireframe(noteService: noteService)

    ListWireframe().configure(listViewController: listViewController, noteService: noteService, editorWireframe: editorWireframe)
  }
}
