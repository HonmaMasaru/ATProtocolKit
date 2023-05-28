// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ATProtocolKit",
    platforms: [
        .iOS(.v16), .macOS(.v13)
    ],
    products: [
        .library(name: "ATProtocolKit", targets: ["ATProtocolKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "ATProtocolKit", dependencies: []),
        .testTarget(name: "ATProtocolKitTests", dependencies: ["ATProtocolKit"]),
    ]
)
