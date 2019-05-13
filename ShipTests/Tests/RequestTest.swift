@testable import Ship
import XCTest

private final class RequestTest: XCTestCase {
    func testVersion() {
        XCTAssertNil(RequestStub1().basePathComponent)
        XCTAssertEqual(RequestStub2().basePathComponent?.basePath, "/stub")
    }
}

private struct PathComponentStub: RequestBasePathComponent {
    var basePath: String? {
        return "/stub"
    }
}

private struct RequestStub1: Ship.Request {
    var method: HTTPMethod = .get
    var path = ""
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Data {
        return Data()
    }
}

private struct RequestStub2: Ship.Request {
    var method: HTTPMethod = .get
    var path = ""
    var basePathComponent: PathComponentStub? = .init()
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Data {
        return Data()
    }
}
