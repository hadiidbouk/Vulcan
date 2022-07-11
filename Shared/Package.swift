// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "Shared",
	platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]),
    ],
    dependencies: [],
    targets: [
		.target(
            name: "Shared",
            dependencies: [],
			resources: [.process("Resources")]
		),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared"]),
    ]
)
