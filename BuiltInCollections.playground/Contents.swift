import Foundation

//Arrays and Mutability

var x = [1,2,3]

//Here, y makes a copy of x, so it does not have a reference to it. Changing y wont change x, and vice versa
var y = x

y.append(4)

print(y)
print(x)

//NSArray and NSMutableArray are different

let a = NSMutableArray(array: [1,2,3])
let b: NSArray = a

//b is an immutable type, NSArray, but it can be mutated via a. because b is a reference to a
a.insert(4, at: 3)
print(b)

//To make a copy with NSArray/NSMutableArray, we need to explicitly use a copy
let c = NSMutableArray(array: [1,2,3])
let d = c.copy() as! NSArray

c.insert(4, at: 3)
print(d)

// "In Swift, mutability is defined by declaring with var instead of let"
// All Swift collection types implement copy-on-write, so the data is only copied when neccesary.
// So x and y have the same internal storage until y.append() is called

// "It's pretty rare in Swift to actually need to calculate an index"
let arr1 = [1,2,3,4,5,6,7,8,9,10]

// iterate over all but first element
for x in arr1.dropFirst() {
    print(x)
}

// iterate over all but the las5 elements
for x in arr1.dropLast(5) {
    print(x)
}

// number all the elements in an erray
for (num, element) in arr1.enumerated() {
    print("index: \(num) - element: \(element)")
}

// Finding the location of a specific element
if let idx = arr1.index(where: { $0 == 4 }) {
    print(idx)
}

// Transform all elements in an array
let add1 = arr1.map { $0 + 1 }
print(add1)

// Filter array
let evens = arr1.filter { $0 % 2 == 0 }
print(evens)


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

// "Standard Map function does not specify whether it transfosms the sequence in order"

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

//Reduce: Combining all elements in to one value
let fibs = [0,1,1,2,3,5]
let sum = fibs.reduce(0) { total, num in total + num }
print(sum)

let stringOfFibs = fibs.reduce("") { str, num in str + "\(num)" }
print(stringOfFibs)

//How reduce is implemented
extension Array {
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
}

//You can even use reduce to re-write map and filter, although it goes from O(n) to O(n^2)
extension Array {
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]) {
            $0 + [transform($1)]
        }
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            isIncluded($1) ? $0 + [$1] : $0
        }
    }
}

//FlatMap -- Taking an array of arrays, and making one array

//For example, this function (fake right now), will return a list of links from a page
func extractLinks(markDownFile: String) -> [URL] {
    return [ URL.init(string: "Link1")!, URL.init(string: "Link2")!, URL.init(string: "Link3")! ]
}

// But if we had a list of many files and we want to get all of the links from those files, we would have to map it then join them
let markDownFiles: [String] = ["File1", "File2", "File3"]
let nestedLinks = markDownFiles.map { extractLinks(markDownFile: $0)}
print(nestedLinks)
let links = nestedLinks.joined()
print(links)

// Instead we could do this
let markDownFiles2: [String] = ["File1", "File2", "File3"]
let links2 = markDownFiles.flatMap { extractLinks(markDownFile: $0) }
print(links2)


// Flatmap can also be used to combine elements from different arrays
let suits = ["♠️", "❤️", "♣️", "♦️"]
let ranks = ["J","Q","K","A"]

let result = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}
print(result)


























