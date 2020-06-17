//: Gumballs machine example using enum to manage states.
//: I believe this approach a little more native in Swift.

protocol QuarterMachine {
    func insertQuarter ()
    func ejectQuarter ()
    func turnCrank ()
    func despense ()
}

class GumballMachineState : QuarterMachine {
    // TODO: gunballs is a state too, so... probably it 
    // will be better to put it here?
    //class var gunballs = 0
    
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

enum StatesOfGumballMachine  {
    case TurnedOff
    case SoldOut(GumballMachine)
    case NoQuarter(GumballMachine)
    case HasQuarter(GumballMachine)
    case Sold(GumballMachine)
    case LastExtra(GumballMachine)
    
    var handler: GumballMachineState? {
        // TODO: Hm.. better that they were all Singletons
        // or... I can init them all here and make machine
        // an Optional
        switch self {
            case .TurnedOff:
                return nil
            case .SoldOut(let machine):
                return SoldOutState(machine)
            case .NoQuarter(let machine):
                return NoQuarterState(machine)
            case .HasQuarter(let machine):
                return HasQuarterState(machine)
            case .Sold(let machine):
                return SoldState(machine)
            case .LastExtra(let machine):
                return LastExtraState(machine)
        }
    }
}

class SoldOutState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        print("No way. It sold out!")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        print("No way. It sold out!")
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("Nothing happened. It sold out.")
    }
    
    override func despense() {
        super.despense()
        print("No Gunballs.")
    }
}

class NoQuarterState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        print("inserted.")
        machine.state = .HasQuarter(machine)
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        print("nothing.")
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("nothing.")
    }
    
    override func despense() {
        super.despense()
        print("No way. Put you quarter inside first.")
    }
}

class HasQuarterState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        print("no way. There are quarter in place.")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        print("your quarter back!")
        machine.state = .NoQuarter(machine)
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("crrck!")
         machine.state = .Sold(machine)
    }
    
    override func despense() {
        super.despense()
    }
}

class SoldState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        print("nothing.")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        print("nothing.")
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("nothing.")
    }
    
    override func despense() {
        super.despense()
        print("Gunball!")
        machine.state = .NoQuarter(machine)
        machine.gunballs--
        if machine.gunballs <= 0 {
            print("You are the last costumer, turn crank again to get extra!")
            machine.state = .LastExtra(machine)
        }
    }
}

class LastExtraState : GumballMachineState {
    
    override func insertQuarter() {
        super.insertQuarter()
        print("no need! Just turn the crank.")
    }
    
    override func ejectQuarter() {
        super.ejectQuarter()
        print("nothing.")
    }
    
    override func turnCrank() {
        super.turnCrank()
        print("zrrpuuu!")
    }
    
    override func despense() {
        super.despense()
        print("a Toy for you!")
        machine.state = .SoldOut(machine)
    }
}


class GumballMachine : QuarterMachine {
    var state: StatesOfGumballMachine = .TurnedOff
    
    // TODO: it is state, it should be in GumballMachineState
    var gunballs = 0
    
    init (numberOfGunballs: Int) {
        gunballs = numberOfGunballs
    }
    
    func insertQuarter() {
        state.handler?.insertQuarter()
    }
    
    func ejectQuarter() {
        state.handler?.ejectQuarter()
    }
    
    func turnCrank() {
        state.handler?.turnCrank()
        state.handler?.despense()
    }
    
    func despense() {
        print("Be good. Pay and use crank if you want a gumball")
    }
    
    func refill(numberOfGumballs: Int) {
        self.gunballs += numberOfGumballs
        updateState()
    }
    
    func turnOn() {
        updateState()
    }
    
    // TODO: it is state, it should be in GumballMachineState
    func updateState() {
        if self.gunballs > 0 {
            self.state = .NoQuarter(machine)
        } else {
            self.state = .SoldOut(machine)
        }
    }
    
}

// Click on plus next to return value to see console output in assistant editor
let machine = GumballMachine(numberOfGunballs: 10)
machine.turnOn()

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
