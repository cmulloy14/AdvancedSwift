import Foundation

//Filter

// Chaining map and filter
// All even squares
let evenSquares = (1..<10).map { $0 * $0 }.filter { $0 % 2 == 0}
print(evenSquares)

//What filter looks like:
extension Array {
    func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        var result: [Element] = []
        for x in self where try isIncluded(x) {
            result.append(x)
        }
        return result
    }
}

// For checking if an element is in an array, use contains
evenSquares.contains { $0 == 36 }

// What if we want to check if all elements in a sequence match a predicate? Write an extension duh
extension Sequence {
    func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}

let allEvens = evenSquares.all { $0 % 2 == 0}
