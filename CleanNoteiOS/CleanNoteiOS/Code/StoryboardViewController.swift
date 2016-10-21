import UIKit

class StoryboardViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let coordinator = StoryboardSegueCoordinator(segue: segue, sender: sender)
        
        coordinator.prepare()
        
    }
    
}
