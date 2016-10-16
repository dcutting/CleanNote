import UIKit
import CleanNoteCore

extension EditorViewController: Segueable {
    func accept(visitor: StoryboardViewControllerVisitor){
        visitor.process(self)
    }
}

extension StoryboardSegueCoordinator {
    
    internal func process(_ viewController: EditorViewController) {
        guard let source = segue.source as? ListViewController else { return }
        let noteID = noteIDFrom(object: sender) ?? noteIDForSelectedRowIn(tableView: source.tableView)!
        source.editorWireframe.configure(editorViewController: viewController, noteID: noteID)
    }
    
    fileprivate func noteIDFrom(object: Any?) -> NoteID? {
        guard let noteIDWrapperObject = object as? NoteIDWrapperObject else { return nil }
        return noteIDWrapperObject.id
    }
    
    private func noteIDForSelectedRowIn(tableView :UITableView) -> NoteID? {
        let indexPath = tableView.indexPathForSelectedRow
        guard let selectedRow = indexPath?.row else { return nil }
        return noteIDFor(row: selectedRow)
    }
    
    fileprivate func noteIDFor(row: Int) -> NoteID? {
        guard let source = segue.source as? ListViewController else { return nil }
        guard let listViewNote = source.list?.notes[row] else { return nil }
        return listViewNote.id
    }
    
}

