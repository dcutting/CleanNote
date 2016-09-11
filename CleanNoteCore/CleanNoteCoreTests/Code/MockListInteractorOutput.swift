import CleanNoteCore

class MockListInteractorOutput: ListInteractorOutput {
  var expectedList: List?
  var actualList: List?
  var spiedDidFail: RetryableError<ListError>?

  func expect(update list: List) {
    expectedList = list
  }

  func assert() -> Bool {
    guard let actualList = actualList else { return false }
    return expectedList == actualList
  }

  func update(list: List) {
    actualList = list
  }

  func didFail(error: RetryableError<ListError>) {
    spiedDidFail = error
  }
}
