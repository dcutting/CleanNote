import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let navController = window?.rootViewController as! UINavigationController
        let listViewController = navController.topViewController as! ListViewController
        let noteService = NoteService()
        let listPresenter = ListPresenter(interface: listViewController)
        let listInteractor = ListInteractor(output: listPresenter, service: noteService)
        listViewController.interactor = listInteractor

        return true
    }
}
