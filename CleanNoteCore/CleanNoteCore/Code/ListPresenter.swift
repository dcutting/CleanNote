public struct ListViewNote {
  public let id: NoteID
  public var summary: String
}

extension ListViewNote: Equatable {}

public func ==(lhs: ListViewNote, rhs: ListViewNote) -> Bool {
  return lhs.id == rhs.id && lhs.summary == rhs.summary
}

public protocol ListInterface {
  func update(notes: [ListViewNote])
}

public class ListPresenter: ListInteractorOutput {
  let interface: ListInterface

  public init(interface: ListInterface) {
    self.interface = interface
  }

  public func didFetch(notes: [Note]) {
    let listViewNotes = notes.map(makeListViewNote)
    interface.update(notes: listViewNotes)
  }

  private func makeListViewNote(for note: Note) -> ListViewNote {
    let summaryText = summary(for: note.text)
    return ListViewNote(id: note.id, summary: summaryText)
  }

  private func summary(for text: String) -> String {
    if text.isEmpty { return "<empty>" }
    return nonEmptySummary(for: text)
  }

  private func nonEmptySummary(for text: String) -> String {
    return text// text.replacingOccurrences(of: "\n", with: " ")
  }
}
