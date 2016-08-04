public protocol EditorInterface {
  func update(text: String)
  func show(error: String)
}

public class EditorPresenter: EditorInteractorOutput {
  let interface: EditorInterface

  public init(interface: EditorInterface) {
    self.interface = interface
  }

  public func didFetch(text: String) {
    interface.update(text: text)
  }

  public func didFailToFetchText() {
    interface.show(error: "Failed to fetch note")
  }

  public func didFailToSaveText() {
    interface.show(error: "Failed to save note")
  }
}
