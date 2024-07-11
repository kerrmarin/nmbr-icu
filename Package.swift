// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nmbr-icu",
    products: [
        .library(name: "nmbr-icu", targets: ["nmbr-icu"])
    ],
    targets: [
        // Main NMBR target, contains 1 ObjC++ file (h + mm)
        .target(name: "nmbr-icu",
                dependencies: ["ICU"]),
        // Target to build the ICU framework, an xcframework for the ICU C++ code
        .binaryTarget(name: "ICU",
                      path: "./ICU.xcframework"),
        // Test target
        .testTarget(name: "nmbrTests", dependencies: ["nmbr-icu"])
    ],
    cxxLanguageStandard: .cxx20
)
