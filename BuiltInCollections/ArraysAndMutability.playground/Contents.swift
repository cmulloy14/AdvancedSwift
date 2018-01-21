import Foundation

// Arrays and Mutability

var x = [1,2,3]

// Here, y makes a copy of x, so it does not have a reference to it. Changing y wont change x, and vice versa
var y = x

y.append(4)

print(y)
print(x)

// NSArray and NSMutableArray are different

let a = NSMutableArray(array: [1,2,3])
let b: NSArray = a

// b is an immutable type, NSArray, but it can be mutated via a. because b is a reference to a
a.insert(4, at: 3)
print(b)

// To make a copy with NSArray/NSMutableArray, we need to explicitly use a copy
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
