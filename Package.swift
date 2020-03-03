// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftNest",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/haoyuant/SwiftKCP.git", from: "1.1.2"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.14.0"),
        .package(url: "https://github.com/apple/swift-nio-extras.git", from: "1.4.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftNest",
            dependencies: ["SwiftKCP", "NIO", "NIOExtras", "SwiftProtobuf"]),
        .testTarget(
            name: "SwiftNestTests",
            dependencies: ["SwiftNest"]),
    ]
)
