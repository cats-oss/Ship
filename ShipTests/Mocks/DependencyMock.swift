import Ship
import Foundation

final class DependencyMock: Dependency {
    var baseURL = URL(string: "http://test.test")!
    var headerFields: [String: String] = [:]

    func buildBaseURL<R: Request>(_ request: R) -> URL {
        return baseURL
    }

    func buildHeaderFields<R: Request>(_ request: R) -> [String: String] {
        return headerFields
    }
}
