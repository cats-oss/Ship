// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Ship",
    platforms: [.macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "Ship", targets: ["Ship"])
    ],
    dependencies: [
        .package(url: "https://github.com/ishkawa/APIKit.git", .upToNextMinor(from: "5.0.0"))
    ],
    targets: [
        .target(name: "Ship", dependencies: ["APIKit"], path: "Ship"),
        .testTarget(name: "ShipTests", dependencies: ["Ship"], path: "ShipTests")
    ],
    swiftLanguageVersions: [.v5]
)
