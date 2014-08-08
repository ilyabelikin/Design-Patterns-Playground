//
// # Motivation
//
// In many cases you can feel craving for an object which should exist
// as one and only one and be accesable whenever you want it. Classical
// examples is a configuration file, logging tool, hardware device 
// or data storage.
//
// Singleton feels very natural and simple to adopt, so there are 
// tendency to overuse it. Pattern of relation with this pattern looks
// like: first use, love, love, love, big project, hate, hate, hate, 
// post in blog why you should never ever use it.
//
// # Definition
//
// Singleton pattern ensures a class has only one instance and provides
// a global access point to it.
//
// # Implementation
//
class Singleton {
    
    var data = 0
    // TODO: Update when class constant will be implemented (not yet in beta5)
    //class let instance = Singleton()
    
    // Using private struct instead
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
// # Overuse
//
// In case of overuse everithing will be glue up to a global
// state and it will make overall design simpler, but in the same
// time, much harder to test and change in any way.
//
// http://misko.hevery.com/2008/08/17/singletons-are-pathological-liars/
//
// # Credit card example

let myCard = CreditCard(cardNumber: 1234_5678_9012_3456) // Sometimes fake error in beta5
myCard.charge(100)

// This call will fire few other object and database, which is not
// obvious form API it expose. And which makes it hard to mock 
// this other objects in tests.
// 
// Sidenote: ok, but it looks like there are a lot of software which
// relay on global state to make overall design easy and then just
// but additional efforts to make it testable too. At least in 2008 Rails
// was like that... and it was a huge succed. Which is not made them an
// example of software design, ofcourse.
//
// Sidenote: It feels like if I need to call init() (as it is in original
// post) to use Singleton it is wrong using of pattern in a first place. 
// Or I just need to improve my example to be a litle bit more real.
//
// TODO: Improve this one or make a better example.
//

class CreditCard {
    var number: Int
    
    func charge (amount: Double) {
        let creditCardProcessor = CreditCardProcessor.sharedInstance
        creditCardProcessor.proceesCharge(self, amount: amount)
    }
    
    init (cardNumber: Int) {
        self.number = cardNumber
    }
}

class CreditCardProcessor {
    class var sharedInstance: CreditCardProcessor {
        struct Static { static let instance = CreditCardProcessor() }
        return Static.instance
    }
    
    func proceesCharge(card: CreditCard, amount: Double) {
        let queue = OfflineQueue.sharedInstance
        queue.registreTransaction()
        println("Thank you, your credit card $\(amount) less.")
    }
}

class OfflineQueue {
    class var sharedInstance: OfflineQueue {
        struct Static { static let instance = OfflineQueue() }
        return Static.instance
    }
    
    let db = Database.sharedInstance

    func registreTransaction() {
        db.connect()
        println("Registre transaction")
    }
}

class Database {
    class var sharedInstance: Database {
    struct Static { static let instance = Database() }
        return Static.instance
    }
    
    init () {
        println("Init database model")
    }
    
    func connect () {
        println("Connect to database")
    }
}

//
// More about it from the same author
// http://misko.hevery.com/2008/08/21/where-have-all-the-singletons-gone/
// http://misko.hevery.com/2008/08/25/root-cause-of-singletons/
//