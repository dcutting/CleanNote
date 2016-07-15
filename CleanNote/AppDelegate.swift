import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let navController = window?.rootViewController as! UINavigationController
    let listViewController = navController.topViewController as! ListViewController

    ListWireframe().configure(listViewController: listViewController, noteService: NoteService())

    return true
  }
}