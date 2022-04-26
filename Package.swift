// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "conrad-entry-report",
    defaultLocalization: "en",
    platforms: [.macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ConradEntryReport",
            targets: ["ConradEntryReport"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Plot", from: "0.11.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ConradEntryReport",
            dependencies: ["Plot"]
        ),
        .testTarget(
            name: "ConradEntryReportTests",
            dependencies: ["ConradEntryReport"]
        )
    ]
)
