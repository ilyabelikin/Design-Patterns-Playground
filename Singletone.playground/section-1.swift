// OO Design Patterns
// Singletone: ensures a class has only one instance and provides a global access point to it

class Singletone {
    
    class var sharedInstance: Singletone {
        
        struct Static {
            static let instance = Singletone()
        }
        return Static.instance
    }
    
    
    private init () {
        // TODO: I hope will be a way to use class let istead and pervent new instance here
    }

    var data = 0
}

let singletone = Singletone.sharedInstance
singletone.data = 1

let sameOne = Singletone.sharedInstance

let otherOne = Singletone()
