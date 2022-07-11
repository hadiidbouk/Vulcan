// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "MediaLibrary",
	platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MediaLibrary",
            targets: ["MediaLibrary"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MediaLibrary",
            dependencies: []),
        .testTarget(
            name: "MediaLibraryTests",
            dependencies: ["MediaLibrary"]),
    ]
)
