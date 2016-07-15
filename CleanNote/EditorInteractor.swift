protocol EditorInteractorInput {
}

protocol EditorInteractorOutput {
}

class EditorInteractor: EditorInteractorInput {
  let output: EditorInteractorOutput

  init(output: EditorInteractorOutput) {
    self.output = output
  }
}
