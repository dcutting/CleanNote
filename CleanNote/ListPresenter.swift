struct ListViewNote {
    var summary: String
}

protocol ListViewInterface {
    func set(notes: [ListViewNote])
}

class ListPresenter: ListInteractorOutput {
    var interface: ListViewInterface

    init(interface: ListViewInterface) {
        self.interface = interface
    }

    func found(notes: [Note]) {
        let listNotes = notes.map {
            return ListViewNote(summary: $0.text)
        }
        interface.set(notes: listNotes)
    }
}
