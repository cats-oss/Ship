import APIKit
import Ship
import SwiftProtobuf

struct RequestMock: Ship.Request {
    var method: HTTPMethod = .get
    var path: String = "path"
    var parameters: Any? = "param"
    var basePathComponent: AnyBasePathComponent?
    var queryParameters: [String: Any]? = ["query": "param"]
    var bodyParameters: BodyParameters?
    var dataParser: DataParser = ProtobufDataParser()

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return Google_Protobuf_Empty()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Google_Protobuf_Empty {
        return Google_Protobuf_Empty()
    }
}
