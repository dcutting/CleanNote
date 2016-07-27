public protocol EditorInterface {
  func update(text: String)
  func error(text: String)
}

public class EditorPresenter: EditorInteractorOutput {
  let interface: EditorInterface

  public init(interface: EditorInterface) {
    self.interface = interface
  }

  public func didFetch(text: String) {
    interface.update(text: text)
  }

  public func didFailToSave() {
    interface.error(text: "Failed to save note")
  }
}
