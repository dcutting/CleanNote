import XCTest
@testable import CleanNoteCore
@testable import CleanNoteiOS

class ListViewControllerTests: XCTestCase {

  var interactor: MockListInteractorInput!
  var editorWireframe: MockEditorWireframe!
  var tableView: MockTableView!
  var sut: ListViewController!

  override func setUp() {
    interactor = MockListInteractorInput()

    editorWireframe = MockEditorWireframe(noteGateway: MockNoteGateway())

    tableView = MockTableView()
    tableView.stub(dequeueReusableCell: UITableViewCell(), with: "NoteCell")

    sut = ListViewController()
    sut.interactor = interactor
    sut.editorWireframe = editorWireframe
    sut.tableView = tableView
  }


  func test_viewWillAppear_fetchesNotes() {
    // Arrange.
    interactor.expectFetchNotes()

    // Act.
    sut.viewWillAppear(false)

    // Assert.
    XCTAssert(interactor.assert())
  }


  func test_update_reloadsTableView() {
    // Arrange.
    tableView.expectReloadData()

    // Act.
    sut.update(notes: [])

    // Assert.
    XCTAssert(tableView.assert())
  }


  func test_update_displaysCorrectNumberOfRowsInTable() {
    // Arrange.
    let notes = [
      ListViewNote(id: "1", summary: "sample note"),
      ListViewNote(id: "2", summary: "another sample note")
    ]

    // Act.
    sut.update(notes: notes)

    // Assert.
    let expectedRows = 2
    let actualRows = sut.tableView(tableView, numberOfRowsInSection: 0)
    XCTAssertEqual(expectedRows, actualRows)
  }


  func test_update_displaysCorrectDataInTable() {
    // Arrange.
    let notes = [
      ListViewNote(id: "1", summary: "sample note"),
      ListViewNote(id: "2", summary: "another sample note")
    ]

    // Act.
    sut.update(notes: notes)

    // Assert.
    for row in (0..<notes.count) {
      let indexPath = IndexPath(row: row, section: 0)
      let cell = sut.tableView(tableView, cellForRowAt: indexPath)
      let expectedCellText = notes[row].summary
      let actualCellText = cell.textLabel?.text
      XCTAssertEqual(expectedCellText, actualCellText)
    }
  }


  func test_prepareForSegue_addNote_configuresEditorModuleWithoutNoteID() {
    // Arrange.
    let editorViewController = EditorViewController()
    editorWireframe.expect(configureEditorViewController: editorViewController, noteID: nil)

    let segue = UIStoryboardSegue(identifier: "addNote", source: sut, destination: editorViewController)

    // Act.
    sut.prepare(for: segue, sender: nil)

    // Assert.
    XCTAssert(editorWireframe.assert())
  }


  func test_prepareForSegue_editNote_configuresEditorModuleWithSelectedNoteID() {
    // Arrange.
    let notes = [
      ListViewNote(id: "zero", summary: "sample note"),
      ListViewNote(id: "one", summary: "another sample note")
    ]
    sut.update(notes: notes)

    let indexPath = IndexPath(row: 1, section: 0)
    tableView.stub(indexPath: indexPath, forSelectedRow: 1)

    let editorViewController = EditorViewController()
    editorWireframe.expect(configureEditorViewController: editorViewController, noteID: "one")

    let segue = UIStoryboardSegue(identifier: "editNote", source: sut, destination: editorViewController)

    // Act.
    sut.prepare(for: segue, sender: nil)

    // Assert.
    XCTAssert(editorWireframe.assert())
  }
}
