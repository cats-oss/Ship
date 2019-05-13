import Ship

struct RequestDependency: Dependency {
    let url = URL(string: "https://api.github.com")!

    func buildBaseURL<R: Request>(_ request: R) -> URL {
        return url
    }
}
