//
// # Motivation
//
// In many cases you need an object that should exist as one and only one
// because of it nature. Like an object which represent configuration file,
// hardware device or data storage.
//
// # Definition
//
// Singleton pattern ensures a class has only one instance and provides
// a global access point to it.
//

class Singleton {
    
    var data = 0
    
    // Class constant is not supported yet in beta4
    class var sharedInstance: Singleton {
        struct Static {
            // Constant in Swift thread safe by desing, internaly 
            // it works like if dispatch_once applied
            static let instance = Singleton()
        }
        return Static.instance
    }
 
    private init () { }
}

let object = Singleton.sharedInstance
object.data = 1

let sameObject = Singleton.sharedInstance
sameObject.data = 42

object.data

if Singleton.sharedInstance === object {
    "Ok, it is totally the same thing"
}

//
// TODO: Update when class constant will be implemented in Swift
//
// TODO: Many times I heard that singleton pattern is a bad thing
// be it nature or, at least, because of overuse. It will be great 
// to provide realistic example and explanation when it is the case.
// Someone?
//