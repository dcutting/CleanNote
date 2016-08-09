public protocol ListInteractorInput {
  func fetchNotes()
  func fetch(noteID: NoteID)
  func makeNote()
//  func focus(noteID: NoteID)
}

public protocol ListInteractorOutput {
  func didFetch(notes: [Note])
  func didFetch(note: Note)
  func didMake(note: Note)
//  func didFocus(noteID: NoteID)
}

public class ListInteractor: ListInteractorInput {
  let output: ListInteractorOutput
  let gateway: NoteGateway
//  var focussedNoteID: NoteID?

  public init(output: ListInteractorOutput, gateway: NoteGateway) {
    self.output = output
    self.gateway = gateway
  }

  public func fetchNotes() {
    gateway.fetchNotes {
      self.output.didFetch(notes: $0)
    }
  }

  public func fetch(noteID: NoteID) {
    do {
      try gateway.fetchNote(with: noteID) {
        self.output.didFetch(note: $0)
      }
    } catch {
    }
  }

//  public func focus(noteID: NoteID) {
//    output.didFocus(noteID: noteID)
//  }

  public func makeNote() {
    do {
      let note = try gateway.createNote()
      output.didMake(note: note)
//      output.didFocus(noteID: note.id)
    } catch {}
  }

  private func newNoteText() -> String {
    return ""
  }
}
