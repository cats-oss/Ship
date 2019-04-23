import Foundation

struct RequestProxy<R: Request>: RequestProxyProtocol {
    typealias Request = R
    typealias Response = R.Response

    var request: R
    var baseURL: URL
    var headerFields: [String: String]
    var dependency: Dependency

    init(request: Request, dependency: Dependency) {
        self.request = request
        self.dependency = dependency

        let url = dependency.buildBaseURL(request)
        baseURL = request.basePath.map(url.appendingPathComponent) ?? url
        headerFields = dependency.buildHeaderFields(request)
    }

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        let urlRequest = try dependency.intercept(request: request, urlRequest: urlRequest)
        return try request.intercept(urlRequest: urlRequest)
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        let object = try dependency.intercept(request: request, object: object, urlResponse: urlResponse)
        return try request.intercept(object: object, urlResponse: urlResponse)
    }
}

private extension Request {
    var basePath: String? {
        return basePathComponent?.basePath
    }
}
