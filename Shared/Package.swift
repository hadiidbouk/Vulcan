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
    dependencies: [
		// global
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.9.0"))
	],
    targets: [
		.target(
            name: "Shared",
            dependencies: [
				// global
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
			],
			resources: [.process("Resources")]
		),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared"]),
    ]
)
