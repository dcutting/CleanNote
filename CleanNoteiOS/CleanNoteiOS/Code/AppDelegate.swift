import UIKit
import CleanNoteCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

    let navController = window?.rootViewController as! UINavigationController
    let listViewController = navController.topViewController as! ListViewController

    RootWireframe().configure(listViewController: listViewController)

    return true
  }
}
