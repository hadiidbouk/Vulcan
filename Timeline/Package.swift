// swift-tools-version: 5.6
import PackageDescription

let package = Package(
	name: "Timeline",
	platforms: [.macOS(.v12)],
	products: [
		.library(
			name: "Timeline",
			targets: ["Timeline"]
		),
	],
	dependencies: [
		// local
		.package(path: "../Shared"),

		// global
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.9.0")),
	],
	targets: [
		.target(
			name: "Timeline",
			dependencies: [
				// local
				.product(name: "Shared", package: "Shared"),

				// global
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
			]
		),
		.testTarget(
			name: "TimelineTests",
			dependencies: ["Timeline"]
		),
	]
)
