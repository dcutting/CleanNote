public protocol MakerInteractorInput {
  func makeNote()
}

public protocol MakerInteractorOutput {
  func didMake(note: Note)
}

public class MakerInteractor: MakerInteractorInput {
  let output: MakerInteractorOutput
  let noteGateway: NoteGateway

  public init(output: MakerInteractorOutput, noteGateway: NoteGateway) {
    self.output = output
    self.noteGateway = noteGateway
  }

  public func makeNote() {
    do {
      let note = try noteGateway.createNote()
      output.didMake(note: note)
    } catch {}
  }

  private func newNoteText() -> String {
    return ""
  }
}
