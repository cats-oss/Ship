import APIKit
import SwiftProtobuf

public protocol ProtobufRequest: Request {
    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response
}

public extension ProtobufRequest where Response: Message {
    var dataParser: DataParser {
        return ProtobufDataParser()
    }

    var bodyParameters: BodyParameters? {
        guard let message = parameters as? Message, !method.prefersQueryParameters else {
            return nil
        }

        return ProtobufBodyParameters(message: message)
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard 200..<300 ~= urlResponse.statusCode else {
            let data = object as? Data
            throw ProtobufResponseError.requestFailed(data: data, response: urlResponse)
        }

        return object
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }

        guard let response = try? response(from: data, urlResponse: urlResponse) else {
            throw ProtobufResponseError.parseFailed(data)
        }

        return response
    }

    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(serializedData: data)
    }
}
