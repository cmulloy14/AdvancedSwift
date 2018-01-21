import Foundation

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
