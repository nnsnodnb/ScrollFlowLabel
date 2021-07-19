// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "ScrollFlowLabel",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "ScrollFlowLabel", targets: ["ScrollFlowLabel"])
    ],
    targets: [
        .target(name: "ScrollFlowLabel", dependencies: [], path: "ScrollFlowLabel")
    ]
)
