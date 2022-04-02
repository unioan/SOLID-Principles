//: [Previous](@previous)
/*:
 # Dependancy Inversion
 */
/*:
 ## Overview
 This principle has nothing to do with dependency injection. The dependency inversion states two things:
 - High-level module should not depend on a low-level module but both should depend on abstraction.
 - Abstraction should not depend on details but details should depend on abstraction.
 */
/*:
 ## Example
 It would be easier to demonstrate this principle with an example. Let's imagen we want to create a program where we are going to model people's relationships.
 1. Define an enum with people between whom relationships will be happening. Then we will declare the class Person and define a name property on it.
 */
import Foundation

enum Relationship {
    case child
    case parent
    case sibling
}

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
/*:
 2. Afterward, we are going to define a separate entity to store information about relationships between different people. It will have a property "relations" which is an array of tuples. Each tuple will be containing two Persons and a relationship between them.
 */
class Relationships {
    var relations = [(Person, Relationship, Person)]()
    
    func addParrentChildRelationships(parent: Person, child: Person) {
        relations.append((parent, .parent, child))
        relations.append((child, .child, parent))
    }
}
/*:
  - Important:
  Class Relationships is a **low-level module**. It specifies how to store the information.
 */
/*:
3. Let's then create **high-level module** to research people's relationships. The module's initializer accepts a low-level module and prints the relationships which are stored in its property relations.
 We have two options on how to implement this high-level module:
 */
/*:
 ### Tightly coupled approach
 The approach violates the principle since the high-level module entirely depends on the low-level module. It happens not only because the high-level module's initializer accepts the low-level module as its parameter but also because it directly works with its properties.
*/
class TightlyCoupledResearch {
    
    init(_ r: Relationships) {
        let relations = r.relations
        relations.forEach { person in
            if person.0.name == "John" && person.1 == .parent {
                print("John is a parent of child \(person.2.name)")
            }
        }
    }
}

print(" Tightly coupled approach:")

let parent = Person(name: "John")
let child1 = Person(name: "Tom")
let child2 = Person(name: "Anna")

let relationships = Relationships()
relationships.addParrentChildRelationships(parent: parent, child: child1)
relationships.addParrentChildRelationships(parent: parent, child: child2)

let _ = TightlyCoupledResearch(relationships)
/*:
### Loosley coupled approach
 Ideally, we would want our low-level module's array to be private so that nobody can work with it directly. Additionally, we want to shift the relationship assessment details into a low-level module and hide its implementation because the high-level module doesn't need to know these details. This approach allows us to change data representation without a client object being aware of it.
 Now, we are going to introduce a protocol that will help us to reach the needed level of abstraction and de-couple our code. We will also define new low-level & high-level modules to demonstrate dependency inversion principle fulfillment.
*/
protocol RelationshipBrowser { // This protocol will contain all methods the researcher may use to do a research
    func findChildrenOf(name: String) -> [Person] // Returns an array of all children whose father's name matches to the name in the parameter
}

class BetterRelationships: RelationshipBrowser {
    
    private var relations = [(Person, Relationship, Person)]()
    
    func addParrentChildRelationships(parent: Person, child: Person) {
        relations.append((parent, .parent, child))
        relations.append((child, .child, parent))
    }
    
    func findChildrenOf(name: String) -> [Person] {
        return relations
            .filter { $0.name == name && $1 == .parent && $2 === $2 } // We also use $2 because swift complains if we dont use all arguments
        .map { $2 }
    }
}

class BetterResearch {
    
    init(_ browser: RelationshipBrowser) {
        for p in browser.findChildrenOf(name: "John") {
            print("John is a parent of child \(p.name)")
        }
    }
}

print("\n Loosley coupled approach:")

let betterRelationships = BetterRelationships()

betterRelationships.addParrentChildRelationships(parent: parent, child: child1)
betterRelationships.addParrentChildRelationships(parent: parent, child: child2)

let _ = BetterResearch(betterRelationships)
/*:
  - Important:
 Although the approach might look the same, the key difference is that we don't pass the low-level module **BetterRelationships** as a concrete object to the high-level module initializer. We are passing it as the protocol. Then high-level module communicates with a low-level module through an interface i.e. high-level module depends on the abstraction.
 */
//: [Back to the Single Responsability Principle](SingleResponsibilityPrinciple)
