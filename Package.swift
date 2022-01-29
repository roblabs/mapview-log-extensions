// swift-tools-version:5.2
/// For Xcode 13, use `swift-tools-version:5.5`
/// The `swift-tools-version` declares the minimum version of Swift required to build this `package`.
/// Copyright ePi Rational, Inc. or its affiliates. All Rights Reserved.
/// SPDX-License-Identifier: MIT
import PackageDescription

let package = Package(
    name: "MapView OSLog Extensions",
    platforms: [.tvOS(.v13)],
    products: [
        /// `products` define the executables and libraries produced by a `package`, and make them visible to other packages.
        .library(
            name: "MapView OSLog Extensions",
            /// Add the `targets` to your `product`.
            targets: ["MapViewOSLogExtensions"]),
    ],
    dependencies: [
        /// Dependencies declare other packages that this `package` depends on.
        /// `.package(url: /* package url */, from: "1.0.0"),`
    ],
    targets: [
        /// `targets` are the basic building blocks of a `package`. A `target` can define a module or a test suite.
        /// Targets can depend on other `targets` in this package, and on `products` in packages which this package depends on.
        /// Define the `targets` for the package.
        .target(
            name: "MapViewOSLogExtensions",
            dependencies: []),
        .testTarget(
            name: "MapViewOSLogExtensionsTests",
            dependencies: ["MapViewOSLogExtensions"]),
    ]
)
