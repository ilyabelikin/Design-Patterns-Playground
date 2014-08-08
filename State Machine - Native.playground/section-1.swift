//
// Gumballs machine example using enum to manage states.
// I belive this approach a little more native in Swift.
//

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
        machine.state = .HasQuarter
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
        machine.state = .NoQuarter
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("crrck!")
         machine.state = .Sold
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
        machine.state = .NoQuarter
        machine.gunballs--
        if machine.gunballs <= 0 {
            println("You are the last costumer, turn crank again to get extra!")
            machine.state = .LastExtra
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
        machine.state = .SoldOut
    }
}

enum QuarterMachineStates {
    case TurnedOff, SoldOut, NoQuarter, HasQuarter, Sold, LastExtra
}

class GumballMachine: QuarterMachine {
    var state: QuarterMachineStates = .NoQuarter {
        willSet {
            switch newValue {
                case .TurnedOff:
                    self.stateHandler = nil
                case .SoldOut:
                    self.stateHandler = SoldOutState(self)
                case .NoQuarter:
                    self.stateHandler = NoQuarterState(self)
                case .HasQuarter:
                    self.stateHandler = HasQuarterState(self)
                case .Sold:
                    self.stateHandler = SoldState(self)
                case .LastExtra:
                    self.stateHandler = LastExtraState(self)
            }
        }
    }
    
    var stateHandler: GumballMachineState?
    
    var gunballs = 0
    
    init (numberOfGunballs: Int) {
        gunballs = numberOfGunballs
    }
    
    func turnOnMachine () {
        if gunballs > 0 {
            state = .NoQuarter
        } else {
            state = .SoldOut
        }
    }
    
    func insertQuarter() {
        stateHandler?.insertQuarter()
    }
    
    func ejectQuarter() {
        stateHandler?.ejectQuarter()
    }
    
    func turnCrank() {
        stateHandler?.turnCrank()
        stateHandler?.despense()
    }
    
    func despense() {
        println("Be good. Pay and use crank if you want a gumball")
    }
    
    func refill(numberOfGumballs: Int) {
        self.gunballs  += numberOfGumballs
        self.state = .TurnedOff
    }
}

// Click on plus next to return value to see console output in assistant editor
let machine = GumballMachine(numberOfGunballs: 10)
machine.turnOnMachine()

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
