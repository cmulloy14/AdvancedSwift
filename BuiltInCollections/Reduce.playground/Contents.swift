import Foundation

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
