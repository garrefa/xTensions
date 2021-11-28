// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "xTensions",
    products: [
        .library(
            name: "xTensions",
            targets: ["xTensions"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "xTensions",
            dependencies: []),
        .testTarget(
            name: "xTensionsTests",
            dependencies: ["xTensions"]),
    ]
)
