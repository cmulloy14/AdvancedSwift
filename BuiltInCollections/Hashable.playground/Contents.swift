import Foundation

// Hashable Requirement

// "The dictionary assigns each key a position in its underlying storage array based on the key’s hashValue”

// This is why Dictionary's Key conforms to the Hashable protocol

// “All the basic data types in the standard library already do, including strings, integers, floating-point, and Boolean values”

// So if you want custom types as keys, you must add Hashable conformance

// Two instances that are equal must have the same hash value, but instances with the same hash value do not have to be equal

// So the potential for duplicate hash values means that Dictionary must be able to handle collisions

// “i.e. the hash function should produce a uniform distribution over the full integer range”

// It is important that the hash function is fast, because it is computed everytime a key is inserted, removed, or looked up

// For types that are composed of basic types, XOR'ing the members is a good starting point

struct Person {
    var name: String
    var zipCode: Int
    var birthday: Date
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.zipCode == rhs.zipCode && lhs.birthday == rhs.birthday
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return name.hashValue ^ zipCode.hashValue ^ birthday.hashValue
    }
}

// Limitation of XORing is a^b == b^a, which could make collisions more likely. This is avoidable by adding a bitwise rotation

// “Finally, be extra careful when you use types that don’t have value semantics (e.g. mutable objects) as dictionary keys. If you mutate an object after using it as a dictionary key in a way that changes its hash value and/or equality, you’ll not be able to find it again in the dictionary. The dictionary now stores the object in the wrong slot, effectively corrupting its internal storage. This isn’t a problem with value types because the key in the dictionary doesn’t share your copy’s storage and therefore can’t be mutated from the outside.”
