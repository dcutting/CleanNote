import Foundation

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
  func select(row: Int)
  func deselectAllRows()
  func didFailToMakeNote()
}

public class ListPresenter: ListInteractorOutput {
  let interface: ListInterface

  public init(interface: ListInterface) {
    self.interface = interface
  }

  public func update(list: List) {
    let listViewNotes = list.notes.map(makeListViewNote)
    interface.update(notes: listViewNotes)
    updateSelection(for: list)
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
    return text.replacingOccurrences(of: "\n", with: " ")
  }

  private func updateSelection(for list: List) {
    if let row = list.selectedRow {
      interface.select(row: row)
    } else {
      interface.deselectAllRows()
    }
  }

  public func didFailToMakeNote() {
    interface.didFailToMakeNote()
  }
}
