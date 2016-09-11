import CleanNoteCore

class RootWireframe {
  func configure(listViewController: ListViewController) {

    let sampleNotes = makeSampleNotes()
    let inMemoryNoteGateway = InMemoryNoteGateway(notes: sampleNotes)

    let failureRate = UInt32(20)
    let randomNumberGenerator = UniformRandomNumberGenerator()
    let errorGenerator = RandomErrorGenerator(failOneIn: failureRate, randomNumberGenerator: randomNumberGenerator)
    let randomlyFailingGateway = RandomlyFailingNoteGatewayDecorator(noteGateway: inMemoryNoteGateway, errorGenerator: errorGenerator)

    let noteGateway = randomlyFailingGateway

    let editorWireframe = EditorWireframe(noteGateway: noteGateway)

    ListWireframe().configure(listViewController: listViewController, noteGateway: noteGateway, editorWireframe: editorWireframe)
  }

  private func makeSampleNotes() -> [Note] {
    let note1 = Note(id: "1", text: "Hello world")
    let note2 = Note(id: "2", text: "Goodbye cruel world")
    return [note1, note2]
  }
}
