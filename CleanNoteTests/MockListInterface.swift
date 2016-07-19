@testable import CleanNote

class MockListInterface: ListInterface {
  var actualNotes: [ListViewNote]?

  func update(notes: [ListViewNote]) {
    actualNotes = notes
  }
}
