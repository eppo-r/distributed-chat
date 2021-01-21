// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DistributedChatCLI",
    products: [
        .executable(
            name: "DistributedChatCLI",
            targets: ["DistributedChatCLI"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../DistributedChat"),
        .package(path: "../DistributedChatSimulationProtocol"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DistributedChatCLI",
            dependencies: [
                .product(name: "DistributedChat", package: "DistributedChat"),
                .product(name: "DistributedChatSimulationProtocol", package: "DistributedChatSimulationProtocol"),
            ]
        ),
        .testTarget(
            name: "DistributedChatCLITests",
            dependencies: [
                .target(name: "DistributedChatCLI")
            ]
        )
    ]
)