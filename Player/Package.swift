// swift-tools-version: 5.6
import PackageDescription

let package = Package(
	name: "Player",
	platforms: [.macOS(.v12)],
	products: [
		.library(
			name: "Player",
			targets: ["Player"]
		),
	],
	dependencies: [],
	targets: [
		.target(
			name: "Player",
			dependencies: []
		),
		.testTarget(
			name: "PlayerTests",
			dependencies: ["Player"]
		),
	]
)
