import XCTest

@testable import SortedCollection

struct Person {
    let name: String
    let age: Int
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return (lhs.age == rhs.age) && (lhs.name == rhs.name)
    }
}

extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
}

final class SortedCollectionTests: XCTestCase {

    let missingPrefix = Person(name: "a", age: 0)
    let missingInfix  = Person(name: "d", age: 3)
    let missingSuffix = Person(name: "g", age: 6)

    let haystack: [Person] = [
        Person(name: "b", age: 1),
        Person(name: "c", age: 2),
        Person(name: "c", age: 2),
        Person(name: "e", age: 4),
        Person(name: "e", age: 4),
        Person(name: "f", age: 5)
    ]
    
    func test_lowerBound() throws {
        let testCases = [
            // Calling `lowerBound(of: ...)` for an existent element with
            // no occurrence it returns the insertion index:
            (self.missingPrefix, 0),
            (self.missingInfix, 3),
            (self.missingSuffix, 6),

            // Calling `lowerBound(of: ...)` for an existent element with
            // a single occurrence it returns the match's index:
            (self.haystack[0], 0),
            (self.haystack[5], 5),

            // Calling `lowerBound(of: ...)` for an existent element with
            // multiple occurrences it returns the first match's index:
            (self.haystack[1], 1),
            (self.haystack[4], 3),
        ]
        
        let haystack = SortedCollection(
            sorted: self.haystack,
            for: \.age
        )

        for (needle, expectation) in testCases {
            XCTAssertEqual(haystack.lowerBound(
                of: needle.age
            ), expectation)
        }
    }

    func test_upperBound() throws {
        let testCases = [
            // Calling `upperBound(of: ...)` for an existent element with
            // no occurrence it returns the index after the insertion index:
            (self.missingPrefix, 0),
            (self.missingInfix, 3),
            (self.missingSuffix, 6),

            // Calling `upperBound(of: ...)` for an existent element with
            // a single occurrence it returns the index after the last match's index:
            (self.haystack[0], 1),
            (self.haystack[5], 6),

            // Calling `upperBound(of: ...)` for an existent element with
            // multiple occurrences it returns the first match's index:
            (self.haystack[1], 3),
            (self.haystack[4], 5),
        ]
        
        let haystack = SortedCollection(
            sorted: self.haystack,
            for: \.age
        )

        for (needle, expectation) in testCases {
            XCTAssertEqual(haystack.upperBound(
                of: needle.age
            ), expectation)
        }
    }

    func test_firstIndex() throws {
        let testCases = [
            // Calling `firstIndex(of: ...)` for an existent element with
            // no occurrence it returns nil:
            (self.missingPrefix, nil),
            (self.missingInfix, nil),
            (self.missingSuffix, nil),

            // Calling `firstIndex(of: ...)` for an existent element with
            // a single occurrence it returns the match's index:
            (self.haystack[0], 0),
            (self.haystack[5], 5),

            // Calling `firstIndex(of: ...)` for an existent element with
            // multiple occurrences it returns the first match's index:
            (self.haystack[1], 1),
            (self.haystack[4], 3),
        ]

        let haystack = SortedCollection(
            sorted: self.haystack,
            for: \.age
        )
        
        for (needle, expectation) in testCases {
            XCTAssertEqual(haystack.firstIndex(
                of: needle.age
            ), expectation)
        }
    }

    func test_range() throws {
        let testCases: [(Person, Range<Int>?)] = [
            // Calling `firstIndex(of: ...)` for an existent element with
            // no occurrence it returns nil:
            (self.missingPrefix, nil),
            (self.missingInfix, nil),
            (self.missingSuffix, nil),

            // Calling `firstIndex(of: ...)` for an existent element with
            // a single occurrence it returns the matches' range:
            (self.haystack[0], 0..<1),
            (self.haystack[5], 5..<6),

            // Calling `firstIndex(of: ...)` for an existent element with
            // multiple occurrences it returns the matches' range:
            (self.haystack[1], 1..<3),
            (self.haystack[4], 3..<5),
        ]
        
        let haystack = SortedCollection(
            sorted: self.haystack,
            for: \.age
        )

        for (needle, expectation) in testCases {
            XCTAssertEqual(haystack.range(
                of: needle.age
            ), expectation)
        }
    }

    func test_lowerBound_benchmark() throws {
        let size: Int = 1_000_000
        
        let haystack = SortedCollection(sorted: Array(0..<size))
        let needle = size
        
        self.measure {
            let _ = haystack.lowerBound(of: needle)
        }
    }
    
    func test_upperBound_benchmark() throws {
        let size: Int = 1_000_000
        
        let haystack = SortedCollection(sorted: Array(0..<size))
        let needle = size
        
        self.measure {
            let _ = haystack.upperBound(of: needle)
        }
    }
    
    func test_firstIndex_benchmark() throws {
        let size: Int = 1_000_000
        
        let haystack = SortedCollection(sorted: Array(0..<size))
        let needle = size
        
        self.measure {
            let _ = haystack.firstIndex(of: needle)
        }
    }
    
    func test_range_benchmark() throws {
        let size: Int = 1_000_000
        
        let haystack = SortedCollection(sorted: Array(0..<size))
        let needle = size
        
        self.measure {
            let _ = haystack.range(of: needle)
        }
    }
    
    static var allTests = [
        ("test_lowerBound", test_lowerBound),
        ("test_upperBound", test_upperBound),
        ("test_firstIndex", test_firstIndex),
        ("test_range", test_range),
        ("test_lowerBound_benchmark", test_lowerBound_benchmark),
        ("test_upperBound_benchmark", test_upperBound_benchmark),
        ("test_firstIndex_benchmark", test_firstIndex_benchmark),
        ("test_range_benchmark", test_range_benchmark),
    ]
}
