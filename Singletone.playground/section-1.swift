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
// # Why it is a bad thing
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
//
// TODO: Nedded a better example. Anyone?
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

    func registreTransaction() { }
}

class Database {
    class var sharedInstance: Database {
    struct Static { static let instance = Database() }
        return Static.instance
    }
}

//
// More about it from the same author
// http://misko.hevery.com/2008/08/21/where-have-all-the-singletons-gone/
// http://misko.hevery.com/2008/08/25/root-cause-of-singletons/
//