@testable import Ship
import APIKit
import XCTest

private final class RequestProxyProtocolTest: XCTestCase {
    func testInit() {
        let url = URL(string: "https://example.com")!
        let headerFields = ["Header": "Fields"]

        let request = RequestMock()
        let proxy = try! RequestProxyMock(request: request, baseURL: url, headerFields: headerFields)
        XCTAssertEqual(proxy.baseURL, url)
        XCTAssertEqual(proxy.headerFields, headerFields)
        XCTAssertEqual(proxy.method, request.method)
        XCTAssertEqual(proxy.path,  request.path)
        XCTAssertEqual(proxy.parameters as? String, "param")
        XCTAssertEqual(proxy.queryParameters?["query"] as? String, "param")
        XCTAssertNil(proxy.bodyParameters)
        XCTAssertEqual(proxy.dataParser.contentType, "application/protobuf")
        XCTAssertEqual(try! proxy.intercept(urlRequest: URLRequest(url: url)).url, url)
        XCTAssertEqual(try! proxy.intercept(object: "", urlResponse: HTTPURLResponse()) as? String, "intercept")
        XCTAssertEqual(try! proxy.response(from: "", urlResponse: HTTPURLResponse()), "response")
    }
}
