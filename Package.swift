// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let cipherCSettings: [CSetting] = [
    .define("SQLITE_HAS_CODEC"),
]

let cipherSwiftSettings: [SwiftSetting] = [
    .define("SQLITE_HAS_CODEC"),
    .define("GRDBCIPHER"),
    .define("SQLITE_ENABLE_FTS5"),
]

let package = Package(
    name: "GRDB",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "GRDB", targets: ["GRDB"]),
    ],
    dependencies: [
        .package(url: "https://github.com/signalapp/sqlcipher", exact: "4.6.1-signal.1"),
    ],
    targets: [
        .target(
            name: "CSQLite",
            dependencies: [.product(name: "SQLCipher", package: "sqlcipher")],
            path: "Sources/CSQLite",
            publicHeadersPath: "."),
        .target(
            name: "GRDB",
            dependencies: ["CSQLite"],
            path: "GRDB",
            cSettings: cipherCSettings,
            swiftSettings: cipherSwiftSettings),
        .testTarget(
            name: "GRDBTests",
            dependencies: ["GRDB"],
            path: "Tests",
            exclude: [
                "CocoaPods",
                "CustomSQLite",
                "Crash",
                "Performance",
                "SPM",
                "GRDBTests/getThreadsCount.c",
            ],
            cSettings: cipherCSettings,
            swiftSettings: cipherSwiftSettings)
    ],
    swiftLanguageVersions: [.v5]
)
