import CleanNoteCore

class MockListInterface: ListInterface {
  var spiedUpdateList: ListViewList?

  func update(list: ListViewList) {
    spiedUpdateList = list
  }

  public func present(error: RetryableError<ListError>) {
  }
}
