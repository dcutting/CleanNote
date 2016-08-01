import Cocoa

class FullViewAnimator: NSObject, NSViewControllerPresentationAnimator {

    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
      
        let superview = fromViewController.view
        let subview = viewController.view
        
        superview.addSubview(subview)
        configureBorder(view: subview)
        configureConstraints(superview: superview, subview: subview)
    }
    
    func configureBorder(view: NSView) {
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.gray.cgColor
        view.layer?.borderWidth = 0.0
    }
    
    func configureConstraints(superview: NSView, subview: NSView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[dest]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["dest": subview])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[dest]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["dest": subview])
        
        superview.addConstraints(horizontalConstraints)
        superview.addConstraints(verticalConstraints)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.removeFromSuperview()
    }
}
