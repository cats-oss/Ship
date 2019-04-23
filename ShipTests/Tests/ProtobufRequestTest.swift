@testable import Ship
import APIKit
import SwiftProtobuf
import XCTest

private final class ProtobufRequestTest: XCTestCase {
    func testDataParser() {
        XCTAssertTrue(ProtobufRequestStub().dataParser is ProtobufDataParser)
    }

    func testBodyParameters() {
        var request = ProtobufRequestStub()
        XCTAssertNil(request.bodyParameters)

        request.parameters = ""
        XCTAssertNil(request.bodyParameters)

        request.parameters = Google_Protobuf_Empty()
        request.method = .get
        XCTAssertNil(request.bodyParameters)

        request.parameters = Google_Protobuf_Empty()
        request.method = .post
        XCTAssertTrue(request.bodyParameters is ProtobufBodyParameters)
    }

    func testIntercept() {
        let request = ProtobufRequestStub()
        let url = URL(string: "https://example.com")!
        XCTAssertEqual(try? request.intercept(object: "object", urlResponse: HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
                )!) as? String, "object")

        XCTAssertEqual(try? request.intercept(object: "object", urlResponse: HTTPURLResponse(
            url: url,
            statusCode: 299,
            httpVersion: nil,
            headerFields: nil
            )!) as? String, "object")

        let response = HTTPURLResponse(url: url, statusCode: 300, httpVersion: nil, headerFields: nil)!
        do {
            let data = try? Google_Protobuf_Empty().serializedData()
            _ = try request.intercept(object: data as Any, urlResponse: response)
            XCTFail()
        } catch {
            if case ProtobufResponseError.requestFailed(let data, let response) = error {
                XCTAssertNotNil(data.flatMap { try? Google_Protobuf_Empty(serializedData: $0) })
                XCTAssertEqual(response.statusCode, 300)
            } else {
                XCTFail()
            }
        }
    }

    func testResponse() {
        let request = ProtobufRequestStub()
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let stringData = "test".data(using: .utf8)!
        let protoData = try? Google_Protobuf_Empty().serializedData()

        do {
            _ = try request.response(from: "test", urlResponse: response)
            XCTFail()
        } catch {
            if case ResponseError.unexpectedObject(let object) = error {
                XCTAssertEqual(object as? String, "test")
            } else {
                XCTFail()
            }
        }

        do {
            _ = try request.response(from: stringData as Any, urlResponse: response)
            XCTFail()
        } catch {
            XCTAssertEqual(error as? ProtobufResponseError, .parseFailed(stringData))
        }

        do {
            _ = try request.response(from: stringData, urlResponse: response)
            XCTFail()
        } catch {
            XCTAssertEqual(error as? BinaryDecodingError, .malformedProtobuf)
        }

        XCTAssertEqual(try? request.response(from: protoData as Any, urlResponse: response), Google_Protobuf_Empty())
        XCTAssertEqual(try? request.response(from: protoData!, urlResponse: response), Google_Protobuf_Empty())
    }
}

private struct ProtobufRequestStub: ProtobufRequest {
    typealias Response = Google_Protobuf_Empty
    var method: HTTPMethod = .get
    var path = ""
    var parameters: Any?
}
