import XCTest
@testable import SortedCollection

final class SortedCollectionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SortedCollection().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
