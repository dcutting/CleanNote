import CleanNoteCore

class MockListInterface: ListInterface {
  var spiedUpdateList: ListViewList?
  var spiedPresentError: RetryableError<ListError>?

  func update(list: ListViewList) {
    spiedUpdateList = list
  }

  public func present(error: RetryableError<ListError>) {
    spiedPresentError = error
  }
}
