@testable import Ship
import APIKit
import XCTest

private final class SessionTest: XCTestCase {
    func testInit() {
        let configuration = URLSessionConfiguration.default
        _ = Session(dependency: DependencyMock(), sessionConfiguration: configuration)
        XCTAssertEqual(configuration.timeoutIntervalForRequest, 15)
        XCTAssertEqual(configuration.timeoutIntervalForResource, 60)
    }

    func testSend() {
        let configuration = URLSessionConfiguration.default
        let session = Session(dependency: DependencyMock(), sessionConfiguration: configuration)
        XCTAssertNotNil(session.send(RequestMock(), handler: { _ in }))
    }
}
