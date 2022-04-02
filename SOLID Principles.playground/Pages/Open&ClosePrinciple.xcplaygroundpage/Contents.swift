//: [Previous](@previous)
/*:
 # Open/Close principle
 */
/*:
 ## Overview
 This principle states that an object has to be open for extension but closed for modification. By extension, we understand the addition of new functionality to a class whereas modification means changing a class itself to add new functionality.
 */
/*:
 ## Why should we avoid modifying a class?
 Adding new functionality to a class directly may introduce bugs in previously written and tested methods.
 */
/*:
 ## How do I know that I'm actually modifying a class rather than extending it?🙀
 Class modification is easy to spot. Let's look at the example:
 
 * Callout(We have a concrete class):
 The class has a method that sorts items of type Product by color.
 ````
 class Product {
 
 func filterByColor(_ items: [Product], spec: Color) -> [Product]
 
 }
 ````
 * Callout(Adding new functionality):
 Sometimes later we want to be able to sort not only by color but also by size and size&&color as well. Adding new functions directly to our concrete class is considered to be a modification of the class.
 ````
 class Product {
 
 func filterByColor(_ items: [Product], spec: Color) -> [Product]
 func filterBySize(_ items: [Product], spec: Size) -> [Product]
 func filterBySize(_ items: [Product], size: Size, color: Color) -> [Product]
 
 }
 ````
 */
/*:
  ## How can my code comply with this principle?
 We usually use protocol or abstract class to fulfill this principle.

 */
import Foundation

// Object difinition
enum Color {
    case green, yellow, white, orange
}

enum Size {
    case small, avarage, large
}

class Product {
    let name: String
    let size: Size
    let color: Color
    
    init(name: String, size: Size, color: Color) {
        self.name = name
        self.size = size
        self.color = color
    }
}

// Protocol difinition
protocol Specification {
    associatedtype T
    func isSaticfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], spec: Spec) -> [T] where Spec.T == T
}

// Protocol implementation for concrete objects
class ColorSpecification: Specification {
    typealias T = Product
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func isSaticfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    let size: Size
    
    init(size: Size) {
        self.size = size
    }
    
    func isSaticfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T,
                       SpecA: Specification,
                       SpecB: Specification>: Specification // Type AndSpecification is subscribed on Specification
where SpecA.T == SpecB.T, SpecA.T == T, SpecB.T == T { // Here we just making sure that all types have adopted Specification protocol
    let specA: SpecA
    let specB: SpecB
    
    init(specA: SpecA, specB: SpecB) {
        self.specA = specA
        self.specB = specB
    }
    
    func isSaticfied(_ item: T) -> Bool { // We don't use associated type since we don't know the object type in advance
        return specA.isSaticfied(item) && specB.isSaticfied(item)
    }
    
}

class BetterFilter: Filter {
    typealias T = Product
    
    func filter<Spec: Specification>(_ items: [Product], spec: Spec) -> [Product] where Product == Spec.T {
        var result = [Product]()
        // Compares each item's color with the specification
        items.forEach { item in
            if spec.isSaticfied(item){
                result.append(item)
            }
        }
        return result
    }
}



// Objects initialization
let objectOne = Product(name: "objectOne", size: .small, color: .green)
let objectTwo = Product(name: "objectTwo", size: .avarage, color: .orange)
let objectThree = Product(name: "objectThree", size: .small, color: .white)
let objectFour = Product(name: "objectFour", size: .large, color: .orange)
let objectFive = Product(name: "objectFive", size: .small, color: .green)
let objectSix = Product(name: "objectSix", size: .large, color: .yellow)

let filter = BetterFilter()
let products = [objectOne ,objectTwo, objectThree, objectFour, objectFive, objectSix]
filter.filter(products, spec: AndSpecification(specA: ColorSpecification(color: .green),
                                               specB: SizeSpecification(size: .small)))
//: [Liskov Substitution Principle](@next)
