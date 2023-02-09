// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWAStoreKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WWAStoreKit",
            targets: ["WWAStoreKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/malcommac/SwiftDate.git", branch: "master"),
        .package(url: "https://github.com/mxcl/PromiseKit.git", branch: "master"),
        .package(url: "https://github.com/bizz84/SwiftyStoreKit.git", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WWAStoreKit",
            dependencies: [
                "SwiftDate",
                "PromiseKit",
                "SwiftyStoreKit"
            ]),
        
    ]
)
