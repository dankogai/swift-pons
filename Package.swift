// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PONS",
    products: [
        .library(
            name: "PONS",
            type: .dynamic,
            targets: ["PONS"]),
    ],
    dependencies: [
      .package(url: "https://github.com/dankogai/swift-bignum.git", .branch("master")),
      .package(url: "https://github.com/dankogai/swift-complex.git", .branch("master")),
      .package(url: "https://github.com/dankogai/swift-interval.git", .branch("master")),
            .package(url: "https://github.com/dankogai/swift-int2x.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "PONS",
            dependencies: ["BigNum", "Complex", "Interval", "Int2X"]),
        .target(
            name: "PONSRun",
            dependencies: ["PONS"]),
        .testTarget(
            name: "PONSTests",
            dependencies: ["PONS"]),
    ]
)
