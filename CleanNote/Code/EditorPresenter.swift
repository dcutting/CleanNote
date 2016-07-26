protocol EditorInterface {
  func update(text: String)
  func error(text: String)
}

class EditorPresenter: EditorInteractorOutput {
  let interface: EditorInterface

  init(interface: EditorInterface) {
    self.interface = interface
  }

  func didFetch(text: String) {
    interface.update(text: text)
  }

  func didFailToSave() {
    interface.error(text: "Failed to save note")
  }
}
