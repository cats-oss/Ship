@testable import Ship
import XCTest

private final class AnyBasePathComponentTest: XCTestCase {
    func testInit() {
        XCTAssertEqual(AnyBasePathComponent(basePath: "path").basePath, "path")
    }
}
