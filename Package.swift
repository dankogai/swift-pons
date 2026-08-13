// swift-tools-version:6.0
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
      .package(url: "https://github.com/dankogai/swift-bignum.git", branch: "main"),
      .package(url: "https://github.com/dankogai/swift-complex.git", branch: "main"),
      .package(url: "https://github.com/dankogai/swift-interval.git", branch: "main"),
      .package(url: "https://github.com/dankogai/swift-int2x.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "PONS",
            dependencies: [
                .product(name: "BigNum", package: "swift-bignum"),
                .product(name: "Complex", package: "swift-complex"),
                .product(name: "Interval", package: "swift-interval"),
                .product(name: "Int2X", package: "swift-int2x")
            ]),
        .executableTarget(
            name: "PONSRun",
            dependencies: ["PONS"]),
        .testTarget(
            name: "PONSTests",
            dependencies: ["PONS"]),
    ],
    swiftLanguageModes: [.v5]
)
