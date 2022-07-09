// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Timeline",
	platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Timeline",
            targets: ["Timeline"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Timeline",
            dependencies: []),
        .testTarget(
            name: "TimelineTests",
            dependencies: ["Timeline"]),
    ]
)
