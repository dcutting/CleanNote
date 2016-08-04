class MockListInterface: ListInterface {
  var actualNotes: [ListViewNote]?

  func update(notes: [ListViewNote]) {
    actualNotes = notes
  }

  func update(note: ListViewNote) {
  }
}
