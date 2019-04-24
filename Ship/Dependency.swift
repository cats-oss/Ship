import Foundation

public protocol Dependency {
    func buildBaseURL<R: Request>(_ request: R) -> URL
    func buildHeaderFields<R: Request>(_ request: R) -> [String: String]
    func intercept<R: Request>(request: R, urlRequest: URLRequest) throws -> URLRequest
    func intercept<R: Request>(request: R, object: Any, urlResponse: HTTPURLResponse) throws -> Any
}

public extension Dependency {
    func buildHeaderFields<R: Request>(_ request: R) -> [String : String] {
        return request.headerFields
    }

    func intercept<R: Request>(request: R, urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }

    func intercept<R: Request>(request: R, object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return object
    }
}
