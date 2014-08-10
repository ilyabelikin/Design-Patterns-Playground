//
// TODO: Motivation
//
// Real-world analogy is newspaper subscriprion.
//
// # Definition
//
// The Observer pattern defines a one-to-many dependency between objects
// so that one object change state, all of it dependent are notified and
// can be updated automatically.
//
// Wether station example (basic design)

protocol Observable {
    var observers: [Observer] { get set }
    func registerObserver (observer: Observer)
    func removeObserver (observer: Observer)
    func notifyObservers ()
}

protocol Observer : class {
    // FIXIT: in beta5, serviceKit terminated on desired declaration
    // func update (updatedObject: Observable)
    func update (updatedObject: AnyObject)
}

enum MesureType {
    case Humidity, Temperature, Pressure
}

struct Mesures {
    var data = [MesureType: Double]()
}

class WetherStation: Observable {
   
    var mesures : Mesures = Mesures() {
        didSet {
            println("New data arrived.\n")
            self.notifyObservers()
        }
    }
    
    var observers = [Observer]()
    
    func registerObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(observer: Observer) {
        var checkedObservers = [Observer]()
        for o in observers {
            if o !== observer {
                checkedObservers.append(o)
            }
        }
        observers = checkedObservers
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.update(self)
        }
    }

}

protocol Display {
    func display ()
}

class CurrentConditionDisplay: Observer, Display {
    var temperature: Double?
    
    func update (updatedObject: AnyObject) {
        if let wetherStation = updatedObject as? WetherStation {
            self.temperature = wetherStation.mesures.data[.Temperature] ?? nil
        }
        
        display()
    }
    
    func display() {
        println("--- Current ---")
        if let temp = self.temperature {
            println("Temeperature is \(temp)˚C")
        } else {
            println("We have no idea what is goinig on outside.")
        }
        println()
    }
}


class ForecastDisplay: Observer, Display {
    func update (updatedObject: AnyObject) {
        display()
    }
    
    func display() {
        println("--- Forecast ---")
        // Sorry, just random stuff
        println("Everything is awesome! Everything is good if you part of the heap. Everything is awes-o-o-ome! Till you have a li-i-ink.\n")
    }
}

import Foundation

class WetherStatisticDisplay: Observer, Display {
    var data = [NSTimeInterval: Mesures]()
    
    func update (updatedObject: AnyObject) {
        if let wetherStation = updatedObject as? WetherStation {
            let timeStamp = NSDate().timeIntervalSinceReferenceDate
            data[timeStamp] = wetherStation.mesures
        }
        
        display()
    }
    
    func avarageTemperature () -> Double {
        
        var numberOfMesures = 0
        var sum = 0.0
        
        for (_, value) in data {
            if let temp = value.data[MesureType.Temperature] {
                sum += temp
                numberOfMesures++
            }
        }
        return sum / Double(numberOfMesures)
    }
    
    func display() {
        println("--- Staticstics ---")
        println("Avarage temperature for all time is \(avarageTemperature())\n")
    }
}

let wetherStation = WetherStation()
let current = CurrentConditionDisplay()
let stat = WetherStatisticDisplay()
let forecast = ForecastDisplay()

current.display()

wetherStation.registerObserver(current)
wetherStation.registerObserver(stat)
wetherStation.registerObserver(forecast)

wetherStation.mesures = Mesures(data: [.Humidity : 32.8, .Temperature : 34.4 , .Pressure : 80.0 ])

wetherStation.removeObserver(forecast)

wetherStation.mesures = Mesures(data: [.Humidity : 52.8, .Temperature : 38.7 , .Pressure : 50.0 ])


wetherStation.mesures = Mesures(data: [.Humidity : 70.1, .Temperature : 30.1 , .Pressure : 89.0 ])

wetherStation.notifyObservers()
