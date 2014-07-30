// OO Design Patterns
// Strategy: inheritance and interfaces do not work well to make vary parts of code maintainable.
// First rule: #1 Encapsulate what varies

// Ducks simulator

protocol FlyBehaivor {
    func fly()
}

class FlyWithWings: FlyBehaivor {
    func fly() {
        println("It is flying using wings")
    }
}

class FlyWithRocket: FlyBehaivor {
    func fly() {
        println("It is flying using a fucking ROCKET! Yahoooooo!")
    }
}

class FlyNoWay: FlyBehaivor {
    func fly() {
        println("It can't fly.")
    }
}


protocol QuackBehaivor {
    func quack()
}

class Quack: QuackBehaivor {
    func quack() {
        println("Quack!")
    }
}

class Squeak: QuackBehaivor {
    func quack() {
        println("Squeak!")
    }
}

class Mute: QuackBehaivor {
    func quack()  {
        println("It is silent")
    }
}

class Duck {
    var flyBehaivor: FlyBehaivor
    var quackBehaivor: QuackBehaivor

    init (flyBy: FlyBehaivor, quackBy: QuackBehaivor) {
        flyBehaivor = flyBy
        quackBehaivor = quackBy
    }
    
    func performFly () {
        flyBehaivor.fly()
    }
    
    func performQuack () {
        quackBehaivor.quack()
    }
    
    func swim () {
        println("It swims")
    }
    
    func display () {
        println("Strange duck")
    }
}

class MallardDuck: Duck {
    override func display() {
        println("Mallard duck")
    }
}

class RedheadDuck: Duck {
    override func display() {
        println("Redhead duck")
    }
}

class RubberDuck: Duck {
    override func display() {
        println("Rubber duck")
    }
}

class DecoyDuck: Duck {
    override func display() {
        println("Decoy duck")
    }
}

let red = RedheadDuck(flyBy: FlyWithWings(), quackBy: Quack())
let rubber = RubberDuck(flyBy: FlyNoWay(), quackBy: Squeak())
let decoy = DecoyDuck(flyBy: FlyNoWay(), quackBy: Mute())

red.display()
red.swim()
red.performQuack()
red.performFly()
println()

rubber.display()
rubber.swim()
rubber.performQuack()
rubber.performFly()
println()


println("Give Rubber duck a rocket jet...")
rubber.flyBehaivor = FlyWithRocket()
rubber.performFly()
println()

decoy.display()
decoy.swim()
decoy.performQuack()
decoy.performFly()  
