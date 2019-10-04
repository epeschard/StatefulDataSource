import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StatefulDataSourceTests.allTests),
    ]
}
#endif
