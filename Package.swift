// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-pair",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Pair", targets: ["Pair"]),

        .library(name: "Pair Foundation Integration", targets: ["Pair Foundation Integration"]),
        .library(name: "Pair Test Support", targets: ["Pair Test Support"]),
    ],
    dependencies: [

        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Pair",
            dependencies: [
                .product(name: "Equation", package: "swift-equation"),
                .product(name: "Hash", package: "swift-hash"),
                .product(name: "Comparison", package: "swift-comparison"),
            ],
            path: "Sources/Pair"
        ),
        
        .target(
            name: "Pair Foundation Integration",
            dependencies: [
                .target(name: "Pair"),
            ],
            path: "Sources/Pair Foundation Integration"
        ),
        .target(
            name: "Pair Test Support",
            dependencies: [
                .target(name: "Pair"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Pair Tests",
            dependencies: [
                .target(name: "Pair"),
                .product(name: "Hash", package: "swift-hash"),
                .target(name: "Pair Test Support"),
                .target(name: "Pair Foundation Integration"),
            ],
            path: "Tests/Pair Tests"
        ),
        .testTarget(
            name: "Consolidated Pair Comparison Tests",
            dependencies: [

                .target(name: "Pair"),
                .product(name: "Comparison", package: "swift-comparison"),
            ],
            path: "Tests/Consolidated swift-pair-comparison"
        ),
        .testTarget(
            name: "Consolidated Pair Equation Tests",
            dependencies: [

                .target(name: "Pair"),
                .product(name: "Equation", package: "swift-equation"),
            ],
            path: "Tests/Consolidated swift-pair-equation"
        ),
        .testTarget(
            name: "Consolidated Pair Hash Tests",
            dependencies: [
                .product(name: "Equation", package: "swift-equation"),

                .target(name: "Pair"),
                .product(name: "Hash", package: "swift-hash"),
            ],
            path: "Tests/Consolidated swift-pair-hash"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
