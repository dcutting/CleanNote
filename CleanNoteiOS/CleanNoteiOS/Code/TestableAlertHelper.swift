import UIKit
@testable import CleanNoteiOS

class TestableAlertHelper: AlertHelper {
    var spiedText: String?
    
    override func show(title: String, text: String, controller: UIViewController) {
        spiedText = text
    }
}
