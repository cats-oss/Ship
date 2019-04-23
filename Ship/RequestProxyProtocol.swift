import APIKit

protocol RequestProxyProtocol: Request {
    associatedtype Request: APIKit.Request

    var request: Request { get }
    var baseURL: URL { get }
    var headerFields: [String: String] { get }
}

extension RequestProxyProtocol where Response == Request.Response {
    var method: HTTPMethod {
        return request.method
    }

    var path: String {
        return request.path
    }

    var parameters: Any? {
        return request.parameters
    }

    var queryParameters: [String: Any]? {
        return request.queryParameters
    }

    var bodyParameters: BodyParameters? {
        return request.bodyParameters
    }

    var dataParser: DataParser {
        return request.dataParser
    }

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return try request.intercept(urlRequest: urlRequest)
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return try request.intercept(object: object, urlResponse: urlResponse)
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try request.response(from: object, urlResponse: urlResponse)
    }
}
