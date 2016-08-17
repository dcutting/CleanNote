public protocol ListInteractorInput {
  func fetchNotesAndSelect(noteID: NoteID?)
  func makeNote()
}

public protocol ListInteractorOutput {
  func update(list: List)
  func didFailToMakeNote()
}

public class ListInteractor {
  let output: ListInteractorOutput
  let gateway: NoteGateway

  public init(output: ListInteractorOutput, gateway: NoteGateway) {
    self.output = output
    self.gateway = gateway
  }
}

extension ListInteractor: ListInteractorInput {
  public func fetchNotesAndSelect(noteID: NoteID?) {
    gateway.fetchNotes { notes in
      let list = List(notes: notes, selected: noteID)
      self.output.update(list: list)
    }
  }

  public func makeNote() {
    do {
      let note = try gateway.makeNote()
      fetchNotesAndSelect(noteID: note.id)
    } catch {
      output.didFailToMakeNote()
    }
  }
}
