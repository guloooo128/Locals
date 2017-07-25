// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Locals",
    dependencies: [
        .Package(url: "https://github.com/jatoben/CommandLine.git", "3.0.0-pre1"),
        .Package(url: "https://github.com/onevcat/Rainbow", "2.0.1")
    ]
)
