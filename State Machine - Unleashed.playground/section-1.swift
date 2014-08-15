//
// Gumballs machine exmaple when machine have no idea about it's own 
// possible states.
//
// TODO: Probably better to make all states a Singleton in this case?

protocol QuarterMachine {
    func insertQuarter ()
    func ejectQuarter ()
    func turnCrank ()
    func despense ()
    func refilled ()
}

class GumballMachineState : QuarterMachine {

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
    
    func refilled()  {
        print("Machine refilled")
    }
}

class SoldOutState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
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
        print("No Gunballs.\n")
    }
    
    override func refilled() {
        machine.state = NoQuarterState(machine)
    }
}

class NoQuarterState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        println("inserted.")
        machine.state = HasQuarterState(machine)
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
        machine.state = NoQuarterState(machine)
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("crrck!")
         machine.state = SoldState(machine)
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
        machine.gunballs--
        
        if machine.gunballs <= 0 {
            machine.state = SoldOutState(machine)
        } else {
            machine.state = NoQuarterState(machine)
        }

    }
}

class GumballMachine : QuarterMachine {
    
    var state: QuarterMachine?
    var gunballs = 0
    
    init (numberOfGunballs: Int) {
        self.gunballs = numberOfGunballs
    }
    
    func insertQuarter() {
        state?.insertQuarter()
    }
    
    func ejectQuarter() {
        state?.ejectQuarter()
    }
    
    func turnCrank() {
        state?.turnCrank()
        state?.despense()
    }
    
    func despense() {
        println("Be good. Pay and use crank if you want a gumball")
    }
    
    func refilled() {
        state?.refilled()
    }
    
    func refill(numberOfGumballs: Int) {
        self.gunballs  += numberOfGumballs
        println("Just refill machine to \(self.gunballs) gunballs")
        refilled()
    }
}

let machine = GumballMachine(numberOfGunballs: 10)
machine.state = NoQuarterState(machine)

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
