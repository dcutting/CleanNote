public protocol ListInteractorInput {
  func fetchNotes()
  func makeNote()
}

public protocol ListInteractorOutput {
  func update(list: List)
  func didFailToMakeNote()
}

public class ListInteractor: ListInteractorInput {
  let output: ListInteractorOutput
  let gateway: NoteGateway

  public init(output: ListInteractorOutput, gateway: NoteGateway) {
    self.output = output
    self.gateway = gateway
  }

  public func fetchNotes() {
    fetchNotesAndSelect(note: nil)
  }

  public func makeNote() {
    do {
      let note = try gateway.makeNote()
      fetchNotesAndSelect(note: note)
    } catch {
      output.didFailToMakeNote()
    }
  }

  private func fetchNotesAndSelect(note: Note?) {
    gateway.fetchNotes { notes in
      let row = self.rowFor(note: note, in: notes)
      let list = List(notes: notes, selectedRow: row)
      self.output.update(list: list)
    }
  }

  private func rowFor(note: Note?, in notes: [Note]) -> Int? {
    guard let note = note else { return nil }
    return notes.index(of: note)
  }
}
