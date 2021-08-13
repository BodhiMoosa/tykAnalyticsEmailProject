// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "tykAnalyticsEmailProject",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", .branch("async-await")),
        .package(url: "https://github.com/vapor-community/sendgrid.git", from: "4.0.0"),
        .package(url: "https://github.com/BrettRToomey/Jobs.git", from: "1.1.1")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "SendGrid", package: "sendgrid"),
                .product(name: "Jobs", package: "Jobs")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release)),
                .unsafeFlags([
                                 "-Xfrontend", "-disable-availability-checking",
                                 "-Xfrontend", "-enable-experimental-concurrency",
                             ])
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
