protocol EditorInterface {
  func update(text: String)
}

class EditorPresenter: EditorInteractorOutput {
  let interface: EditorInterface

  init(interface: EditorInterface) {
    self.interface = interface
  }

  func didFetch(text: String) {
    interface.update(text: text)
  }
}
