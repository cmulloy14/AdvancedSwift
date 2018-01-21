import Foundation

// Transforming Arrays - Map

// How map works - writing it ourselves
extension Array {
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result = [T]()
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

// Element is the generic placeholder for whatever type the array contains
// T new placeholder that can represent the result of the element transformation

// Build in Array functions:
// map, flatMap filter, reduce, sequence, forEach, sort, lexicographicallyPrecedes, partition
// index, first, contains, min, max, elementsEqual, starts, split

// Writing our own array extension
// Lets say we want to iterate over an array in reverse and find the first element that matches a certain condition
// If we're not advanced, we would do this:

let names = ["Paula", "Elena", "Zoe"]
var lastNameEndingInA: String?

for name in names.reversed() where name.hasSuffix("a") {
    lastNameEndingInA = name
    break
}
print(lastNameEndingInA ?? "none")

// Lets write an extension that is smart

extension Sequence {
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

let match = names.last { $0.hasSuffix("a")}
print(match ?? "none")
//This is nice because we can have the match be a let instead of a var, with the previous implementation

extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}

[1,2,3,4].accumulate(0, +)
