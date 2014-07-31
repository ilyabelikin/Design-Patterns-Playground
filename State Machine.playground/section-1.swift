//
// # Motivation
//
// "A truth that all programmers know: state management is why we get paid."
// by Alexandros Salazar
// Read whole post: http://nomothetis.svbtle.com/immutable-swift
//
// Any program manage states and, idealy, should be exhaustive. In other words
// proigrm should have a correct behaivor for any combination of states. 
// This way we will have bug-free software. So... we now it is not the case.
//
// In practice it is quite usual when program manage only subset of possiable
// states and even do not express awarness about possiable states of underling
// object in explicid way. It is just in bunches of if and else statments all 
// over a sorce code.
//
// # Definition
//
// The State Pattern allows an object to alert its behaivor when its 
// internal state change. The object will appear to change its class.
//
// # Examples
// ## Gumball machine

protocol QuarterMachine {
    func insertQuarter ()
    func ejectQuarter ()
    func turnCrank ()
    func despense ()
}

class GumballMachineState: QuarterMachine {
    
    let machine: GumballMachine
    
    init (_ machine: GumballMachine){
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

class SoldOutState: GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        // In reality, wich we pretend to model, it is complitly
        // okay to put Quarter in sold out machine. I belive to
        // model it better we can use two different objects with
        // independent states for each gunballs pool with crank 
        // and quarters slot
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

class NoQuarterState: GumballMachineState {
    
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

class HasQuarterState: GumballMachineState {
    
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

class SoldState: GumballMachineState {
    
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
            println("You are the last costumer, turn crank again to get extra!")
            machine.state = LastExtraState(machine)
        }
    }
}

class LastExtraState: GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        println("no need! Just turn the crank.")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        println("nothing.")
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("zrrpuuu!")
    }
    
    override func despense() {
        super.despense()
        println("a Toy for you!")
    }
}


class GumballMachine: QuarterMachine {

    let soldOutState: SoldOutState!
    let noQuarterState: NoQuarterState!
    let hasQuarterState: HasQuarterState!
    let soldState: SoldState!
    
    var state: GumballMachineState!
    
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
    
    func refill(numberOfGumballs: Int) {
        self.gunballs  += numberOfGumballs
        self.state = self.noQuarterState
    }
}

let machine = GumballMachine(numberOfGunballs: 10)

// Click on plus next to return value to see console in assistant editor

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

