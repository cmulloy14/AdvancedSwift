import Foundation

// Sets - unordered collection of elements
// Pretty much a Dictionary with keys and no values
// Testing a value for membership is a constant time operation, so each element must be hashable
// So use a Set when you need to test efficiently for membership, and order is not important, and you need to ensure there is no duplicates

// Conforms to ExpressibleByArrayLiteral protocol, which means we can initialize it with an array literal

let naturals: Set = [1, 2, 3, 2]
print(naturals) // [2, 3, 1]
naturals.contains(3) // true
naturals.contains(0) // false”


// We can subtract things from Sets

let iPods: Set = ["iPod touch", "iPod nano", "iPod mini",
                  "iPod shuffle", "iPod Classic"]
let discontinuedIPods: Set = ["iPod mini", "iPod Classic"]
let currentIPods = iPods.subtracting(discontinuedIPods)

// And we can find the intersection of two sets
let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
let iPodsWithTouch = iPods.intersection(touchscreen)

// And we can find the union of two sets
var discontinued: Set = ["iBook", "Powerbook", "Power Mac"]
discontinued.formUnion(discontinuedIPods)

// Most Set methods have mutating and non-mutating methods, the mutating methods usually start with 'form'
let disontinued2 = discontinued.union(discontinuedIPods)

// Index Sets and Character Sets - they conform to SetAlgebra too
// IndexSet stores continuos ranges internally, which is much more efficient than a Set<Int>
// If you have 1000 row table, and the first 500 rows are selected, IndexSet only needs two numbers, the upper and lower bound to store this.

var indices = IndexSet()
indices.insert(integersIn: 1..<5)
indices.insert(integersIn: 11..<15)
let evenIndices = indices.filter { $0 % 2 == 0 } // [2, 4, 12, 14]


// We can use an internal Set in a Sequence extension to maintain order of a Sequence

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            }
            else {
                seen.insert($0)
                return true
            }
        }
    }
    
}

// Gets unique elements while still maintaining order original array
[1,2,3,12,1,3,4,5,6,4,6].unique()
