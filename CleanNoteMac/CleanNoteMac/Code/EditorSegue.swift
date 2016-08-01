import Cocoa

public class EditorSegue: NSStoryboardSegue {
  public override func perform() {
    let destination = destinationController as! EditorViewControllerMac
    let source = sourceController as! ListViewControllerMac
    let editorContainer = source.editorContainer

    if let presentedViewController = editorContainer?.presentedViewControllers?.first {
      editorContainer?.dismissViewController(presentedViewController)
    }

    editorContainer?.presentViewController(destination, animator: FullViewAnimator())
  }
}
