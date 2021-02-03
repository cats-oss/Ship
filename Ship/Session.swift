import APIKit

open class Session {
    private let session: APIKit.Session
    private let dependency: Dependency

    public init(dependency: Dependency, sessionConfiguration: URLSessionConfiguration = .default) {
        self.dependency = dependency
        sessionConfiguration.timeoutIntervalForRequest = 15
        sessionConfiguration.timeoutIntervalForResource = 60
        let adapter = URLSessionAdapter(configuration: sessionConfiguration)
        session = APIKit.Session(adapter: adapter, callbackQueue: .sessionQueue)
    }

    @discardableResult
    open func send<R: Request>(_ request: R, callbackQueue: CallbackQueue? = nil, handler: @escaping (Result<R.Response, SessionTaskError>) -> Void) -> SessionTask? {
        let proxy = RequestProxy(request: request, dependency: dependency)
        return session.send(proxy, callbackQueue: callbackQueue, handler: handler)
    }
}
