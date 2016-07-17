class EditorWireframe {
  func configure(editorViewController: EditorViewController) {
    let editorPresenter = EditorPresenter(interface: editorViewController)
    let editorNote = EditorNote(noteID: nil, text: "Sample note")
    let editorInteractor = EditorInteractor(output: editorPresenter, editorNote: editorNote)
    editorViewController.interactor = editorInteractor
  }
}
