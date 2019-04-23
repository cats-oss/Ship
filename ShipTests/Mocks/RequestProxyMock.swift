@testable import Ship
import Foundation

final class RequestProxyMock<R: Request>: RequestProxyProtocol {
    typealias Request = R
    typealias Response = R.Response

    var request: R
    var baseURL: URL
    var headerFields: [String: String]

    init(request: Request, baseURL: URL, headerFields: [String: String]) throws {
        self.request = request
        self.baseURL = baseURL
        self.headerFields = headerFields
    }
}
