import APIKit
import Ship

struct RequestMock: Ship.Request {
    var method: HTTPMethod = .get
    var path: String = "path"
    var parameters: Any? = "param"
    var basePathComponent: AnyBasePathComponent?
    var queryParameters: [String: Any]? = ["query": "param"]
    var bodyParameters: BodyParameters?
    var dataParser: DataParser = ProtobufDataParser()
    var headerFields: [String: String] = ["Header": "Fields"]

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return "intercept"
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> String {
        return "response"
    }
}
