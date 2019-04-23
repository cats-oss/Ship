@testable import Ship
import APIKit
import SwiftProtobuf
import XCTest

private final class ProtobufBodyParameters_MessageTest: XCTestCase {
    func testInit() {
        XCTAssertNotNil(ProtobufBodyParameters(message: Google_Protobuf_Empty()))
    }
}
