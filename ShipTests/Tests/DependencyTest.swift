@testable import Ship
import XCTest

private final class DependencyTest: XCTestCase {
    let request = RequestMock()
    let url = URL(string: "http://test.test")!

    func testInterceptRequest() {
        let urlRequest = URLRequest(url: url)
        let dependency1 = DependencyStub1()
        XCTAssertEqual(try! dependency1.intercept(request: request, urlRequest: urlRequest).url, url)

        var dependency2 = DependencyStub2()
        dependency2.request = URLRequest(url: URL(string: "http://mock.mock")!)
        XCTAssertEqual(try! dependency2.intercept(request: request, urlRequest: urlRequest).url, URL(string: "http://mock.mock"))
    }

    func testInterceptResponse() {
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let dependency1 = DependencyStub1()
        XCTAssertEqual(try! dependency1.intercept(request: request, object: "test", urlResponse: response) as? String, "test")

        var dependency2 = DependencyStub2()
        dependency2.object = "mock"
        XCTAssertEqual(try! dependency2.intercept(request: request, object: "test", urlResponse: response) as? String, "mock")
    }
}

private struct DependencyStub1: Dependency {
    var baseURL = URL(string: "http://test.test")!
    var headerFields: [String: String] = [:]

    func buildBaseURL<R: Request>(_ request: R) -> URL {
        return baseURL
    }

    func buildHeaderFields<R: Request>(_ request: R) -> [String: String] {
        return headerFields
    }
}

private struct DependencyStub2: Dependency {
    var baseURL = URL(string: "http://test.test")!
    var headerFields: [String: String] = [:]
    var request: URLRequest?
    var object: Any?

    func buildBaseURL<R: Request>(_ request: R) -> URL {
        return baseURL
    }

    func buildHeaderFields<R: Request>(_ request: R) -> [String: String] {
        return headerFields
    }

    func intercept<R: Request>(request: R, urlRequest: URLRequest) throws -> URLRequest {
        return self.request ?? urlRequest
    }

    func intercept<R: Request>(request: R, object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return self.object ?? object
    }
}
