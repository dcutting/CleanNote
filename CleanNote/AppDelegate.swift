import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let listViewController = window?.rootViewController as! ListViewController
        let noteService = NoteService()
        let listPresenter = ListPresenter(interface: listViewController)
        let listInteractor = ListInteractor(service: noteService, output: listPresenter)
        listViewController.interactor = listInteractor

        return true
    }
}
