/*

# Motivation

Inheritance is not working very well as approach to separate code that
very in bunch of classes with different behavior.

# Ducks example

It feels natural to have parent class Duck and inherit every other type
of duck form it. It works well for Mallard Duck and Redhead Duck but
what if you someday will need to add Rubber duck or even Decoy duck?
In this case you will need to override methods such as fly() and quack()
in unnatural way.

Rubber and Decoy duck classes probably will suffer more and more from
heredity when design will evolve with new changes and features requests.

Inheritance express IS-A relation, which is not always the better way
to model things. HAS-A relation for vary parts ca be a better choice.

# Definition

The Strategy pattern defines a family of algorithms, encapsulate each
one, and makes them interchangeable. Strategy lets algorithm vary
independently from clients that use it.

*/

// Interface for "family of alghoritms" that Ducks will use
protocol FlyBehaivor {
    func fly()
}

class FlyWithWings : FlyBehaivor {
    func fly() {
        println("It is flying using wings")
    }
}

class FlyWithRocket : FlyBehaivor {
    func fly() {
        println("It is flying using a fucking ROCKET! Yahoooooo!")
    }
}

class FlyNoWay : FlyBehaivor {
    func fly() {
        println("It can't fly.")
    }
}

// And one more "family of alghoritms" for ducks
protocol QuackBehaivor {
    func quack()
}

class Quack : QuackBehaivor {
    func quack() {
        println("Quack!")
    }
}

class Squeak : QuackBehaivor {
    func quack() {
        println("Squeak!")
    }
}

class Mute : QuackBehaivor {
    func quack()  {
        println("Silence.")
    }
}


class Duck {

    // It is variables, because this way we can change behaivors at run time.
    // It is all for Ducks good, see example of usign below.
    var flyBehaivor: FlyBehaivor
    var quackBehaivor: QuackBehaivor

    init (flyBy: FlyBehaivor, quackBy: QuackBehaivor) {
        flyBehaivor = flyBy
        quackBehaivor = quackBy
    }
    
    
    // This methods vary, so we delegate them
    
    func performFly () {
        flyBehaivor.fly()
    }
    
    func performQuack () {
        quackBehaivor.quack()
    }
    
    
    // This methods works well for all kind of ducks, so we just inherit them
    
    func swim () {
        println("It swims")
    }
    
    func display () {
        println("Strange duck")
    }
}

class MallardDuck : Duck {
    override func display() {
        println("Mallard duck")
    }
}

class RedheadDuck : Duck {
    override func display() {
        println("Redhead duck")
    }
}

class RubberDuck : Duck {
    override func display() {
        println("Rubber duck")
    }
}

class DecoyDuck : Duck {
    override func display() {
        println("Decoy duck")
    }
}

// Click on plus next to return value to see console in assistant editor

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

// This playground based on example from http://www.lynda.com/Developer-Programming-Foundations-tutorials/Foundations-Programming-Design-Patterns/135365-2.html
