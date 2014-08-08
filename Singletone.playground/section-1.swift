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
//
// TODO: # Practice
//
// Many times I heard that singleton pattern is a bad thing because
// of its nature or, at least, because tendecy to overuse it. Somehow 
// this topic polarize communities, so I like to collect simple practical 
// examples here to illustrate props and cons people are talking about.
//
//
// # Singletone hide dependencies
// http://misko.hevery.com/2008/08/17/singletons-are-pathological-liars/
//

// If I understand it right, idea is that newcomers on a project can not 
// expect that CreditCard.cgharge() will fire chain of dependencies, and

let myCard = CreditCard(cardNumber: 1234_5678_9012_3456) // Fake error in beta5
myCard.charge(100)

// will do somthing in database. Because is not cleat from API.

// Hm... I belive I see the point, you need explicid dependencies to 
// mock stuff for tests, but what else newcomer actually expect?

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

    func registreTransaction() { }
}

class Database {
    class var sharedInstance: Database {
    struct Static { static let instance = Database() }
        return Static.instance
    }
}
