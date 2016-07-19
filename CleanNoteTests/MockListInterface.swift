@testable import CleanNote

class MockListInterface: ListInterface {
  var notes: [ListViewNote]?

  func update(notes: [ListViewNote]) {
    self.notes = notes
  }
}
