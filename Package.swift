// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnWelcomeKit",
    platforms: [.macOS(.v10_15), .iOS(.v14)],
    products: [
        .library(
            name: "NnWelcomeKit",
            targets: ["NnWelcomeKit"]),
        .library(
            name: "WelcomeUI",
            targets: ["WelcomeUI"]),
        .library(
            name: "WelcomeLogic",
            targets: ["WelcomeLogic"]),
    ],
    dependencies: [
        .package(name: "NnUIKitHelpers",
                 url: "https://github.com/nikolainobadi/NnUIKitHelpers.git",
                 branch: "main")
    ],
    targets: [
        .target(
            name: "NnWelcomeKit",
            dependencies: ["WelcomeUI"]),
        .target(
            name: "WelcomeUI",
            dependencies: ["WelcomeLogic", "NnUIKitHelpers"]),
        .testTarget(
            name: "WelcomeUITests",
            dependencies: ["WelcomeUI", "TestHelpers"]),
        .target(
            name: "WelcomeLogic",
            dependencies: []),
        .testTarget(
            name: "WelcomeLogicTests",
            dependencies: ["WelcomeLogic"]),
        .target(
            name: "TestHelpers",
            dependencies: []),
    ]
)
