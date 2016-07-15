protocol EditorInterface {
}

class EditorPresenter: EditorInteractorOutput {
  let interface: EditorInterface

  init(interface: EditorInterface) {
    self.interface = interface
  }
}
