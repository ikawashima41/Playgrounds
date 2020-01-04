import UIKit
import XCTest

/// Utility class for unit test
class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

/// --------------------
///  Sample Code
/// --------------------

class Sample {}

class SampleTests: XCTestCase {

    func testgetCount() {
        let count = 1
        XCTAssertEqual(count, 1)
    }
}

let observer = TestObserver()
XCTestObservationCenter.shared.addTestObserver(observer)

SampleTests.defaultTestSuite.run()
