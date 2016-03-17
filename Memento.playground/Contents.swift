//: ### Motivation
//:Apparently, badly desire for an ability to undo object state without
//:violating incapsulation.
//: ### Definition
//: The Memento pattern captures and restores an object internal state
//: without violating encapsulation.
//: (In English Memento means an object that kept as a remider of a person
//: or an event)
//: ### Abstract basic example

protocol Mementoable {
    func createMemento () -> Memento
    func restoreFromMemento (momento: Memento)
}

protocol DocumentData {
    var content: String { get set }
}

//: Object which state we care about, "originator"
class Document : DocumentData, Mementoable {
    
    var content = ""
    
    func createMemento () -> Memento {
        return Memento(self.content)
    }
    
    func restoreFromMemento(momento: Memento) {
        self.content = momento.content
    }
}

class Memento : DocumentData {
    var content: String
    
    init (_ content: String) {
        self.content = content
    }
}

//: Object wich take care about originator state, "caretaker"
class Controller {
    
    var document: Document
    var documetnChanges = [Memento]()
   
    init (document: Document) {
        self.document = document
    }
    
    func cahngeDocumentTo (newContent: String) {
        let memento = document.createMemento()
        documetnChanges.append(memento)
        document.content = newContent
    }
    
    func undoDucument () {
        document.restoreFromMemento(documetnChanges[documetnChanges.count - 1])
    }
}

let document = Document()
let controller = Controller(document: document)

controller.cahngeDocumentTo("Oh, please, not that again.")
document.content

controller.cahngeDocumentTo("I am going to change the world!")
document.content

controller.undoDucument()
document.content
