//Optionals

import Foundation

// Sentinel Values: A vlaue whose presence indicates that an error occured of some sort.
// i.e. passing in an error pointer to a network request call

// while let, I guess you can do this
var arr = [1,2,3,4]

while let val = arr.popLast() {
    print(val)
}

let array = [1, 2, 3]
var iterator = array.makeIterator()
while let i = iterator.next() {
    print(i, terminator: " ")
}

// Hey, you can use a where clause in a for-loop, do this more often
for i in 0..<10 where i % 2 == 0 {
    print(i, terminator: " ")
}

// A where in a for loop is different though, it acts more like filter
// A where in a while loop will not execute unless the clause is met

//* a for in loop is essentialy a while let

//Doubly Wrapped Optionals

let stringNumbers = ["1", "2", "three"]
let maybeInts = stringNumbers.map { Int($0) }


//iterator 2 here is a double optional value
var iterator2 = maybeInts.makeIterator()
while let maybeInt = iterator2.next() {
    print(maybeInt ?? "No value")
}

// only the non-nil values
for case let i? in maybeInts {
    print(i)
}

// only the nil values
for case nil in maybeInts {
    print("No value")
}

// ~= operator can be overloaded for case matching in swift
// func ~=<T, U>(_: T, _: U) -> Bool { return true } makes every case statement return true


//Defered intialization.
extension String {
    var fileExtension: String? {
        guard let period = index(of: ".") else {
            return nil
        }
        let extensionRange = index(after: period)..<endIndex
        return String(self[extensionRange])
    }
}

//Never - The return type of functions that do not return normally, that is, a type with no values.
/*
 “Never is what’s called an uninhabited type. It’s a type that has no valid values and thus can’t be constructed. Its only purpose is its signaling role for the compiler. A function declared to return an uninhabited type can never return normally.”
*/
