/*

# Motivation

"A truth that all programmers know: state management is why we get paid."
by Alexandros Salazar
Read whole post: http://nomothetis.svbtle.com/immutable-swift

Any program manage states and, ideally, should be exhaustive. In other
words a program should have a correct behavior for any combination of states.
This way we will have bug-free software. So... we now it is not the case.

In practice it is quite usual when program manage only subset of possible
states and even do not express awareness about possible states of underling
object in explicit way. It is just in bunches of if and else statements all
over a source code.

# Definition

The State Pattern allows an object to alert its behavior when its internal 
state change. The object will appear to change its class.

*/

// # Gumball machine example

// ## Tidilly coupled approach

class GodGunballMachnie {
    
    enum States { case SoldOut, NoQuarter, HasQuarter, Sold }
    var state : States = .NoQuarter
    
    func inserQuarter () {
        print("You are going to insert Quarter... ")
        
        switch state {
            case .SoldOut:
                println("No way. It sold out!")
            case .NoQuarter:
                self.state = .HasQuarter
                println("inserted.")
            case .HasQuarter:
                println("no way. There are quarter in place.")
            case .Sold:
                println("no way.")
        }
    }
    
    // And the same structure for all machine methods.
    
    // To add any new state you will need to open this class
    // and modify each switch statement.
}

// ## Decoupled approach

// Interface for machine and all states classes
protocol QuarterMachine {
    func insertQuarter ()
    func ejectQuarter ()
    func turnCrank ()
    func despense ()
}

// Base class for states of machine
class GumballMachineState : QuarterMachine {
    
    let machine : GumballMachine
    
    init (_ machine : GumballMachine){
        self.machine = machine
    }
    
    func insertQuarter() {
        print("You are going to insert Quarter... ")
    }
    
    func ejectQuarter() {
        print("You are pushing eject button... ")
    }
    
    func turnCrank() {
        print("You are turning crnak... ")
    }
    
    func despense() {
        print(" ... ")
    }
}

class SoldOutState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        // In reality, wich I pretend to model, it is complitly
        // okay to put Quarter in sold out machine. I belive to
        // model it better I can use two different objects with
        // independent states for each gunballs pool with crank 
        // and quarters slot.
        println("No way. It sold out!")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        println("No way. It sold out!")
    }
    
    override func turnCrank() {
        super.turnCrank()
        println("Nothing happened. It sold out.")
    }
    
    override func despense() {
        super.despense()
        print("No Gunballs.")
    }
}

class NoQuarterState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        println("inserted.")
        machine.state = machine.hasQuarterState
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        println("nothing.")
    }
    
    override func turnCrank() {
        super.turnCrank()
        println("nothing.")
    }
    
    override func despense() {
        super.despense()
        println("No way. Put you quarter inside first.")
    }
}

class HasQuarterState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        println("no way. There are quarter in place.")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        println("your quarter back!")
        machine.state = machine.noQuarterState
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("crrck!")
         machine.state = machine.soldState
    }
    
    override func despense() {
        super.despense()
    }
}

class SoldState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        println("nothing.")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        println("nothing.")
    }
    
    override func turnCrank() {
        super.turnCrank()
        println("nothing.")
    }
    
    override func despense() {
        super.despense()
        println("Gunball!")
        machine.state = machine.noQuarterState
        machine.gunballs--
        if machine.gunballs <= 0 {
            machine.state = machine.soldOutState
        }
    }
}

class GumballMachine : QuarterMachine {
    
    let soldOutState : SoldOutState!
    let noQuarterState : NoQuarterState!
    let hasQuarterState : HasQuarterState!
    let soldState : SoldState!

    var state : GumballMachineState!
    var gunballs = 0
    
    init (numberOfGunballs: Int) {
        self.soldOutState = SoldOutState(self)
        self.noQuarterState = NoQuarterState(self)
        self.hasQuarterState = HasQuarterState(self)
        self.soldState = SoldState(self)
        
        gunballs = numberOfGunballs
        if numberOfGunballs > 0 {
            state = noQuarterState
        } else {
            state = soldOutState
        }
    }
    
    func insertQuarter() {
        state.insertQuarter()
    }
    
    func ejectQuarter() {
        state.ejectQuarter()
    }
    
    func turnCrank() {
        state.turnCrank()
        state.despense()
    }
    
    func despense() {
        println("Be good. Pay and use crank if you want a gumball")
    }
    
    func refill(numberOfGumballs : Int) {
        self.gunballs  += numberOfGumballs
        self.state = self.noQuarterState
    }
}

// Click on plus next to return value to see console in assistant editor
let machine = GumballMachine(numberOfGunballs: 10)

machine.despense()

machine.turnCrank()
machine.insertQuarter()
machine.ejectQuarter()
machine.turnCrank()
machine.insertQuarter()
machine.turnCrank()

for _ in 1...10 {
    machine.insertQuarter()
    machine.turnCrank()
}

machine.refill(100)

machine.insertQuarter()
machine.turnCrank()

// This playground based on example from http://www.lynda.com/Developer-Programming-Foundations-tutorials/Foundations-Programming-Design-Patterns/135365-2.html

