import Foundation

let fibs = [0,1,1,2,3,5]

// Array Types - Slices

// Getting a few items from an array view subscript will return a slice
let fibs2 = [0,1,1,2,3,5]
let slice = fibs2[1..<fibs.endIndex]
print(slice)
type(of: slice)


// ArraySlice is a view on array. It is backed by the original array.
// This makes certain that the array doesn't need to get copied

// Reconstructing back a slice back in to an array
let reconstructed = Array(slice)

