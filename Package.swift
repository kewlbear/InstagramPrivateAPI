// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "InstagramPrivateAPI",
    products: [
        .library(
            name: "InstagramPrivateAPI",
            targets: ["InstagramPrivateAPI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "InstagramPrivateAPI",
            dependencies: []),
        .testTarget(
            name: "InstagramPrivateAPITests",
            dependencies: ["InstagramPrivateAPI"]),
    ]
)
