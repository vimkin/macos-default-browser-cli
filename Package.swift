// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DefaultBrowserCLIApp",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "1.2.0")),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMinor(from: "0.50.4")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "DefaultBrowserCLIApp", dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
    ]
)
