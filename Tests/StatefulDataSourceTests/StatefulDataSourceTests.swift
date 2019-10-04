import XCTest
@testable import StatefulDataSource

final class StatefulDataSourceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(StatefulDataSource().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
