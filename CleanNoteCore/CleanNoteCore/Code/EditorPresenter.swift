import Foundation

public protocol EditorInterface {
  func update(text: String)
  func show(error: NSError)
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

  public func didFailToFetchText(error: NSError) {
    interface.show(error: error)
  }

  public func didSaveText(for noteID: NoteID) {
    interface.didSaveText(for: noteID)
  }

  public func didFailToSaveText(error: NSError) {
    interface.show(error: error)
  }
}
