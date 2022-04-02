//: [Previous](@previous)
/*:
 # Interface Segregation Principle
 */
/*:
 ## Overview
 As we know from Open/Close principle a protocol is a contract between two objects interacting with each other. As a result, the objects are effectively decoupled from each other since they communicate through a common interface not knowing about each other. This interface "layer" allows the objects not to depend on each other much.
 */
/*:
## What problem does the principle solve?
 Although using protocols helps us to solve the tight coupling problem, we have still to use protocols diligently to avoid the interface pollution phenomenon. It happens when an interface demands an adopting type to implement functionality it doesn't need.
*/
/*:
## How to solve the polluted interface problem?
 If we find that our protocol defines broad functionality we have to think about how we can divide this functionality into smaller blocks. Small interfaces containing specific functionality are called “role interfaces”.
*/
/*:
## Example of the interface segregation principle fulfillment
 1. We want to create a printer object which can print, scan, and send a fax. We suppose that there may be printers that don't support all this functionality. This is why instead of packing all this functionality into one class we will separate these behaviors into different protocols.
*/
import Foundation

struct Document { }

protocol Printer {
    func print(d: Document)
}

protocol Scaner {
    func scan(d: Document)
}

protocol Fax {
    func fax(d: Document)
}
/*:
  - Important:
 If we would have packed all this functionality into one protocol then it had suited a multi-functional printer but to some ordinary printers, the functionality would have been redundant.
 
 ````
 protocol Machine {
    func print(d: Document)
    func scan(d: Document)
    func fax(d: Document)
 }
 
 class MFP: Machine { ✅
    func print(d: Document) {
        ...
    }
    func scan(d: Document) {
        ...
    }
    func fax(d: Document) {
        ...
    }
}

 class OrdinaryPrinter: Machine { ❌
    func print(d: Document) {
        ...
    }
    func scan(d: Document) {
        print("I can't scan")
    }
    func fax(d: Document) {
        print("I can't scan")
    }
}
 ````
 */
/*:
2. The division into multiple interfaces allows us to pick up a suitable interface for a specific printer.
*/
class OrdinaryPrinter: Printer {
    func print(d: Document) {
        // Printing
    }
}

class Photocopier: Printer, Scaner {
    func print(d: Document) {
        // Prints
    }
    func scan(d: Document) {
        // Scans
    }
}
/*:
3. We may combine several protocols into one to create an interface for a multi-functional printer.
*/
protocol MultiFunctionalPrinter: Printer, Scaner, Fax {
    func print(d: Document)
    func scan(d: Document)
    func fax(d: Document)
}

class MFP: MultiFunctionalPrinter {
    func print(d: Document) {
        // Prints
    }
    
    func scan(d: Document) {
        // Scans
    }
    
    func fax(d: Document) {
        // Faxes
    }
}
/*:
## Conclusion
 We try to separate functionality to different interfaces so that the object which doesn't need redundant functionality wouldn't be enforced to implement it. If necessary, we can combine those interfaces into one protocol to get more complicated behavior.
*/
//: [Interface Segregation Principle](@next)
