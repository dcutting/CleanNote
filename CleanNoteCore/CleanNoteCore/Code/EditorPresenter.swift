public protocol EditorInterface {
  func update(text: String)
  func show(error: String)
  func didSaveText(for noteID: NoteID)
}

public class EditorPresenter {
  let interface: EditorInterface

  public init(interface: EditorInterface) {
    self.interface = interface
  }
}

extension EditorPresenter: EditorInteractorOutput {
  public func update(text: String) {
    interface.update(text: text)
  }

  public func didFailToFetchText() {
    interface.show(error: "Failed to fetch note")
  }

  public func didSaveText(for noteID: NoteID) {
    interface.didSaveText(for: noteID)
  }

  public func didFailToSaveText() {
    interface.show(error: "Failed to save note")
  }
}
