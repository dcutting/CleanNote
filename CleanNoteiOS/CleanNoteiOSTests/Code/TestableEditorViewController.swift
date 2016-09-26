import UIKit
@testable import CleanNoteCore
@testable import CleanNoteiOS

class TestableEditorViewController: EditorViewController {
    
    var alertHelperSpy: TestableAlertHelper {
        get {
            return super.alertHelper as! TestableAlertHelper
        }
    }
    
    var fakeNavigationController = UINavigationController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        alertHelper = TestableAlertHelper()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var navigationController: UINavigationController? {
        return fakeNavigationController;
    }
}
