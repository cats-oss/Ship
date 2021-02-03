import APIKit

public protocol Request: APIKit.Request {
    associatedtype Component: RequestBasePathComponent

    var basePathComponent: Component? { get }
}

public extension Request {
    var basePathComponent: AnyBasePathComponent? {
        return nil
    }

    var baseURL: URL {
        fatalError("have to override")
    }
}
