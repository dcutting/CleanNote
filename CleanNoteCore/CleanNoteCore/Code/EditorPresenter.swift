public protocol EditorInterface {
  func update(text: String)
  func present(error: EditorError)
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

  public func didSaveText(for noteID: NoteID) {
    interface.didSaveText(for: noteID)
  }

  public func didFail(error: EditorError) {
    interface.present(error: error)
  }
}
