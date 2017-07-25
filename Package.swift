// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Locals",
    targets: [
        Target(name: "LocalsKit", dependencies: []),
        Target(name: "Locals", dependencies: ["LocalsKit"])
    ],
    
    dependencies: [
        .Package(url: "https://github.com/jatoben/CommandLine.git", "3.0.0-pre1"),
        .Package(url: "https://github.com/onevcat/Rainbow", "2.0.1"),
        .Package(url: "https://github.com/kylef/PathKit", "0.8.0")
    ]
)
