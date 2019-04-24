@testable import Ship
import XCTest

private final class RequestProxyTest: XCTestCase {
    func testBaseURL() {
        let dependency = DependencyMock()
        XCTAssertEqual(RequestProxy(request: RequestMock(), dependency: dependency).baseURL.path, "")
        var request = RequestMock()
        request.basePathComponent = AnyBasePathComponent(basePath: "/v1")
        XCTAssertEqual(RequestProxy(request: request, dependency: dependency).baseURL.path, "/v1")
    }

    func testHeaderFields() {
        let dependency = DependencyMock()
        XCTAssertEqual(RequestProxy(request: RequestMock(), dependency: dependency).headerFields, ["Header": "Fields"])
    }

    func testInterceptRequest() {
        let dependency = DependencyMock()
        let url = URL(string: "http://test.test")!
        let request = URLRequest(url: url)
        XCTAssertEqual(try! RequestProxy(request: RequestMock(), dependency: dependency).intercept(urlRequest: request).url, url)
    }

    func testInterceptResponse() {
        let dependency = DependencyMock()
        let url = URL(string: "http://test.test")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        XCTAssertEqual(try! RequestProxy(request: RequestMock(), dependency: dependency).intercept(object: "response", urlResponse: response) as? String, "intercept")
    }
}
