# :ship: Ship

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/cats-oss/Ship.svg?branch=master)](https://travis-ci.org/cats-oss/Ship)
[![codecov](https://codecov.io/gh/cats-oss/Ship/branch/master/graph/badge.svg)](https://codecov.io/gh/cats-oss/Ship)
[![Version](https://img.shields.io/cocoapods/v/Ship.svg?style=flat)](http://cocoadocs.org/docsets/Ship)
[![License](https://img.shields.io/cocoapods/l/Ship.svg?style=flat)](http://cocoadocs.org/docsets/Ship)
[![Platform](https://img.shields.io/cocoapods/p/Ship.svg?style=flat)](http://cocoadocs.org/docsets/Ship)

Ship is a [APIKit](https://github.com/ishkawa/APIKit) plugin that can inject common processing to requests on [APIKit](https://github.com/ishkawa/APIKit).

```swift
struct RequestDependency: Dependency {
    var baseURL: URL
    var accessToken: String

    func buildBaseURL<R: APIRequest>(_ request: R) -> URL {
        return baseURL
    }

    func buildHeaderFields<R: APIRequest>(_ request: R) -> [String: String] {
        var headerFields = request.headerFields
        headerFields["authorization"] = "Bearer \(accessToken)"
        return headerFields
    }
}

let session = Session(dependency: RequestDependency())
```

[APIKit](https://github.com/ishkawa/APIKit) is a type-safe networking abstraction layer that is super cool.

## Requirements

- Swift 5.0

## How to Install

#### CocoaPods

Add the following to your `Podfile`:

```Ruby
pod "Ship"
```

#### Carthage

Add the following to your `Cartfile`:

```Ruby
github "cats-oss/Ship"
```

## How to use Ship

### Dependency 

The advantage of Ship is that common processing can be injected.

#### Methods

```swift
func buildBaseURL<R: Request>(_ request: R) -> URL
func buildHeaderFields<R: Request>(_ request: R) -> [String: String]
```

Called each time a request is created. Return the base URL and request header.

```swift
func intercept<R: Request>(request: R, urlRequest: URLRequest) throws -> URLRequest
```

Called each time a request is created. Change the request as needed.

```swift
func intercept<R: Request>(request: R, object: Any, urlResponse: HTTPURLResponse) throws -> Any
```

Called each time of response. Change the response object as needed.

#### Example

```swift
func buildBaseURL<R: APIRequest>(_ request: R) -> URL {
    return URL(string: "https://example.com")!
}

func buildHeaderFields<R: APIRequest>(_ request: R) -> [String: String] {
    var headerFields = request.headerFields
    headerFields["authorization"] = "Token"
    return headerFields
}
```

### Request

Ship's Request inherits APIKit's Request.

#### Variables

```swift
var basePathComponent: Component? { get }
```

Return the base path component.

#### Example

```swift
var basePathComponent: AnyBasePathComponent? {
    return AnyBasePathComponent(basePath: "/v3")
}
```

### RequestBasePathComponent

Can define the components of the request base path.

#### Variables

```swift
var basePath: String? { get }
```

Return the string that is the basis of the path.

#### Example

- Component

```swift
enum APIVersion: String, RequestBasePathComponent {
    case undefined
    case v1
    case v2

    var basePath: String? {
        switch self {
        case .undefined:
            return nil
        default:
            return "/\(rawValue)"
        }
    }
}
```

- Request

```swift
extension Request {
    var basePathComponent: APIVersion? {
        return .v1
    }
}

struct GetUserRequest: Request {
    typealias Response = User

    let method = HTTPMethod.get
    let path = "/me"
}
```

- Dependency

```swift
struct RequestDependency: Dependency {
    func buildBaseURL<R: APIRequest>(_ request: R) -> URL {
        return URL(string: "https://example.com")!
    }
}
```

The session makes a URL like following:

> `https://example.com/v1/me`

## LICENSE
Under the MIT license. See [LICENSE](./LICENSE) file for details.
