public struct AnyBasePathComponent: RequestBasePathComponent {
    public var basePath: String?

    public init(basePath: String?) {
        self.basePath = basePath
    }
}
