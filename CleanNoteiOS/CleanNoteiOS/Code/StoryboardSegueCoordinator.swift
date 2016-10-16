import UIKit

protocol StoryboardViewControllerVisitor {
    func process(_ viewController: EditorViewController)
}

protocol Segueable {
    func accept(visitor: StoryboardViewControllerVisitor)
}

struct StoryboardSegueCoordinator: StoryboardViewControllerVisitor {
    
    let segue: UIStoryboardSegue
    let sender: Any?
    
    func prepare() {
        guard let destination = segue.destination as? Segueable else {return}
        destination.accept(visitor: self)
    }
    
}



