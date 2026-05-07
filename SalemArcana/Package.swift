// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SalemArcana",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SalemArcana",
            targets: ["SalemArcana"]),
    ],
    targets: [
        .target(
            name: "SalemArcana",
            resources: [.process("Resources")]),
        .testTarget(
            name: "SalemArcanaTests",
            dependencies: ["SalemArcana"]),
    ]
)
