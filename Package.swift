// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nmbr-icu",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "nmbr-icu",
            targets: ["nmbr-icu"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "nmbr-icu",
            dependencies: ["ICU"]),
        .binaryTarget(name: "ICU", path: "ICU.xcframework"),
        .testTarget(
            name: "nmbrTests",
            dependencies: ["nmbr-icu"]),
    ],
    cxxLanguageStandard: .cxx20
)
