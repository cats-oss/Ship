import Ship
import Foundation

final class DependencyMock: Dependency {
    var baseURL = URL(string: "http://test.test")!

    func buildBaseURL<R: Request>(_ request: R) -> URL {
        return baseURL
    }
}
