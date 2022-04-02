//: [Previous](@previous)
/*:
 # Liskov Substitution Principle
 */
/*:
 ## Overview
 This principle stipulates that we always shall be able to substitute a parent class for a child class. It means that if a child class is used where its parent class is expected, the child class must be able to perform the task correctly (correctly - means to complete the task with the same result that its parent class would have shown).
 */
/*:
 ## An example of the principle violation.
 1. Let's create a class Rectangle. It will have two stored and two computed properties. We will be using computed properties to retrieve from and save data to stored properties. We also add another computed property to calculate the area of a Rectangle.
 */
class Rectangle {
    
    var _width: Int = 0
    var _height: Int = 0
    
    var width: Int {
        get { return _width }
        set(value) { _width = value }
    }
    
    var height: Int {
        get { return _height }
        set(value) { _height = value }
    }
    
    var area: Int {
        return width * height
    }
    
}
/*:
 2. Then we create a global function that changes Rectangle's width and height. Next, it prints the area of the Rectangle.
 */
func setAndMesure(_ rc: Rectangle) {
    rc.width = 3
    rc.height = 4
    print("We are expecting to see 12 whereas the output is \(rc.area)")
}

let rectangle = Rectangle()
setAndMesure(rectangle) // Prints 12 as expected 🎉
/*:
 3. Let's create a subclass of Rectangle - Square. It has the same properties but different logic for computed properties' setters. The sides have to be the same so that the object can be a square.
 */
class Square: Rectangle {
    
    override var width: Int {
        get { return _width }
        set(value)
        {
            _width = value
            _height = value
        }
    }
    
    override var height: Int {
        get { return _height }
        set(value)
        {
            _width = value
            _height = value
        }
    }
}
/*:
  - Important:
 We have changed the logic of how setters work in the subclass Square. If width is set to a new value, height is also set to the same value and vice versa.
  Results differ because of the new logic. Function setAndMesure(_ rc: Rectangle) tries to set different values for the properties, whereas properties' setters performing their logic set values to be the same.
 */
let square = Square()
setAndMesure(square) // Prints 16 instead of 12 🙀
//: [Next](@next)
