import XCTest
import OSLog
@testable import MapViewOSLogExtensions

final class MapViewOSLogExtensionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        if #available(iOS 12.0, *) {
            print(OSLog.mapEvents.DidBecomeIdle)
        } else {
            // Fallback on earlier versions
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
