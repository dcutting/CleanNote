class MockListInteractorOutput: ListInteractorOutput {
  var expectedNotes = [Note]()
  var actualNotes: [Note]?

  func expect(didFetch notes: [Note]) {
    expectedNotes = notes
  }

  func assert() -> Bool {
    guard let actualNotes = actualNotes else { return false }
    return expectedNotes == actualNotes
  }

  func didFetch(notes: [Note]) {
    actualNotes = notes
  }
}
