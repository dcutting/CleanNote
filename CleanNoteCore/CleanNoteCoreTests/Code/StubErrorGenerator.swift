import CleanNoteCore

class StubErrorGenerator: ErrorGenerator {
  var shouldHaveError: Bool = false

  func stub(hasError: Bool) {
    shouldHaveError = hasError
  }

  func hasError() -> Bool {
    return shouldHaveError
  }
}
