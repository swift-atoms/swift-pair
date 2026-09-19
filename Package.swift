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
    dependencies: [],
    targets: [
        .target(
            name: "Pair",
            dependencies: [],
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
                .target(name: "Pair Test Support"),
                .target(name: "Pair Foundation Integration"),
            ],
            path: "Tests/Pair Tests"
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

// Consumer compilation rejects import visibility regressions.
for target in package.targets where target.type == .test {
    target.swiftSettings = (target.swiftSettings ?? []) + [.treatAllWarnings(as: .error)]
}
