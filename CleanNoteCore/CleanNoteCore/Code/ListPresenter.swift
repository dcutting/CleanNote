import Foundation

public struct ListViewNote {
  public let id: NoteID
  public var summary: String
}

public struct ListViewList {
  public let notes: [ListViewNote]
  public let selected: NoteID?
}

extension ListViewNote: Equatable {}

public func ==(lhs: ListViewNote, rhs: ListViewNote) -> Bool {
  return lhs.id == rhs.id && lhs.summary == rhs.summary
}

public protocol ListInterface {
  func update(list: ListViewList)
  func present(error: NSError)
}

public class ListPresenter {
  let interface: ListInterface

  public init(interface: ListInterface) {
    self.interface = interface
  }
}

extension ListPresenter: ListInteractorOutput {
  public func update(list: List) {
    let listViewNotes = list.notes.map(makeListViewNote)
    let listViewList = ListViewList(notes: listViewNotes, selected: list.selected)
    interface.update(list: listViewList)
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

  public func didFail(error: NSError) {
    interface.present(error: error)
  }
}
