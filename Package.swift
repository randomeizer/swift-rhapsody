// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-rhapsody",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Rhapsody",
            targets: ["Rhapsody"]),
    ],
    dependencies: [
      .package(url: "https://github.com/pointfreeco/swift-overture", .upToNextMajor(from: "0.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Rhapsody",
            dependencies: [
              .product(name: "Overture", package: "swift-overture"),
            ]
        ),
        .testTarget(
            name: "RhapsodyTests",
            dependencies: ["Rhapsody"]),
    ]
)
