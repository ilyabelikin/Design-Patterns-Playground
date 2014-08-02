//
// TODO: Motivation
//
// # Definition
//
// The Factory Method Pattern defines an interface for  creating an object, 
// but lets subclasses decide which class to instantiate. Factory Method 
// lets a class defer instantiation to subclasses.

// # Simple pizza factory example

protocol Pizza {
    func describe ()
}

class PeperoniPizza: Pizza {
    func describe() {
        println("Nice Peperoni Pizza")
    }
}

class HawaiPizza: Pizza {
    func describe() {
        println("Great Hawai Pizza")
    }
}

class MargaritaPizza: Pizza {
    func describe() {
        println("Classic Margarita Pizza")
    }
}

class SimplePizzaFactory {
    func createPizza (name:String) -> Pizza? {
        switch name {
            case "Peperoni":
                return PeperoniPizza()
            case "Hawai":
                return HawaiPizza()
            case "Margarita":
                return MargaritaPizza()
            default:
                return nil
        }
    }
}

class PizzaStore {
    let pizzaFactory: SimplePizzaFactory
    
    init (_ factory: SimplePizzaFactory) {
        self.pizzaFactory = factory
    }
    
    func orderPizza(type: String) {
        println("You just ordered a \(type) pizza.")
        if let pizza = pizzaFactory.createPizza(type) {
            println("Ok. Wait a second, please...")
            pizza.describe()
            println()
        } else {
            println("Sorry, we have no \(type)")
            println()
        }
    }
}

let store = PizzaStore(SimplePizzaFactory())
store.orderPizza("foo")
store.orderPizza("Hawai")
store.orderPizza("Peperoni")
store.orderPizza("Margarita")


