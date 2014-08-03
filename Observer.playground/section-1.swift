//
// TODO: Motivation
//
// # Definition
//
// The Observer pattern defines a one-to-many dependency between objects
// so that one object change state, all of it dependent are notified and
// can be updated automatically.
//

// TODO: # Wether station example (basic design)

protocol Observable {
    var observers: [Observer] { get set }
    func registerObserver (observer: Observer)
    func removeObserver (observer: Observer)
    func notifyObservers ()
}

protocol Observer {
    func update (updatedObject: Observable)
}

class WetherStation: Observable {
   
    var humidity: Double?
    var temperature: Double?
    var pressure: Double?
    
    var observers = [Observer]()
    
    func registerObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(observer: Observer) {

    }
    
    func notifyObservers() {
        
    }

}

protocol Display {
    func display ()
}

class CurrentConditionDisplay: Observer, Display {
    func update (updatedObject: Observable) {
        
    }
    
    func display() {
        
    }
}


class ForecastDisplay: Observer, Display {
    func update (updatedObject: Observable) {
        
    }
    
    func display() {
        
    }
}

class WetherStatisticDisplay: Observer, Display {
    func update (updatedObject: Observable) {
        
    }
    
    func display() {
        
    }
}
