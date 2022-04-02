/*:
 # Single responsibility principle
 */
/*:
 ## Overview
 The single responsibility principle states that a class has to have just one reason to change. It means that a class has to have its specific area of responsibility and it doesn't try to take on responsibilities that can be handed to other parts of the system.
 */
/*:
 ## Example of single responsibility principle violation
 Let's create a journal class. This class will have the following functionality: it can save notes, track the number of notes, remove notes, and save a journal to a file.
 */
class BadJournal {
    
    var enries = [String]()
    var count = 0
    
    // Saves a note and returns the index of a note
    func addEntry(_ text: String) -> Int {
        count += 1
        enries.append("\(count): \(text)")
        return count - 1
    }
    
    // Removes a note
    func removeEntry(_ index: Int) {
        enries.remove(at: index)
    }
    
    // Persists the journal to a file
    func save(_ filename: String, _ overrite: Bool = false) {
        // ...
    }
    
    // Loads file using file name or URI
    func load(filename: String) {
        // ...
    }
    func load(uri: String) {
        // ...
    }
}
/*:
 - Important:
 As it was said earlier the object has to have only one responsibility hence only one reason to change. The responsibility of our journal is to keep track of the entries. If we were to change the rules of how our Journal keeps track of the entries it would be completely fine to change Journal since it is the direct responsibility of our class.
 The violation of the principle has happened when we have added persistence rules to the class. Now, if we were to change persistence rules we would also need to modify Journal. Thus, if we have something like persistence we should keep this functionality in a separate class.
 */
/*:
 ## Example of single responsibility principle fulfillment
 Let's create two classes. One for journal and another for persistence functionality.
 */
class BetterJournal {
    
    var enries = [String]()
    var count = 0
    
    // Saves a note and returns the index of a note
    func addEntry(_ text: String) -> Int {
        count += 1
        enries.append("\(count): \(text)")
        return count - 1
    }
    
    // Removes a note
    func removeEntry(_ index: Int) {
        enries.remove(at: index)
    }
    

}

class Persistence {
    // Saves the journal to a file
    func saveToFile(_ journal: BetterJournal, _ filename: String, _ overrite: Bool = false) {
        // ...
    }
    
    // Loads file using file name or URI
    func load(filename: String) {
        // ...
    }
    
    func load(uri: String) {
        // ...
    }
}

let journal = BetterJournal()
journal.addEntry("Heap to be square")
journal.addEntry("Get up and drive your funky soul")

let persistence = Persistence()
persistence.saveToFile(journal, "Save_1")
//: [Open/Close principle](@next)
