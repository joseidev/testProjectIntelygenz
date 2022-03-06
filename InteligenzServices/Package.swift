// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InteligenzServices",
    platforms: [
         .iOS(.v14),
     ],
    products: [
        .library(
            name: "InteligenzServices",
            targets: ["InteligenzServices"]),
    ],
    dependencies: [
        .package(name: "ServicesLibrary", url: "https://github.com/joseidev/servicesLibrary.git", .branch("main")),
        .package(name: "InteligenzDomain", path: "../InteligenzDomain")
    ],
    targets: [
        .target(
            name: "InteligenzServices",
            dependencies: ["ServicesLibrary", "InteligenzDomain"]),
    ]
)
