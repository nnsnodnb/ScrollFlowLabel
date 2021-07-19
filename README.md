<img src="Resources/ScrollFlowLabelDemo.gif" height="350" align="right">

<h1 align="center">ScrollFlowLabel</h1>

<h4 align="center">
  Display long text on UILabel while scrolling automatically.
</h4>

<p align="center">
  <a href="https://developer.apple.com/swift" target="_blank" ref="noopener">
    <img src="https://img.shields.io/badge/language-Swift%205.0.1-orange.svg" alt="Swift 5.0.1">
  </a>
  <img = src="https://img.shields.io/github/license/nnsnodnb/ScrollFlowLabel.svg" alt="MIT License">
  <a href="https://github.com/nnsnodnb/ScrollFlowLabel/releases/latest" target="_blank" ref="noopener">
    <img alt="Release" src="https://img.shields.io/github/release/nnsnodnb/ScrollFlowLabel.svg">
  </a>
</p>

## Installation

### CocoaPods

```ruby
pod 'ScrollFlowLabel'
```

### Carthage

```
github "nnsnodnb/ScrollFlowLabel" ~> 1.0.0
```

### Swift Package Manager

```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SampleApp",
    dependencies: [
        .package(name: "ScrollFlowLabel",
                 url: "https://github.com/nnsnodnb/ScrollFlowLabel.git",
                 from: "1.0.0")
    ],
    targets: [
        .target(name: "SampleApp", dependencies: ["ScrollFlowLabel"])
    ]
)
```

## Example

### Write source

```swift
let label = ScrollFlowLabel()
label.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor..."
label.textColor = .black
label.textAlignment = .left
label.font = .systemFont(ofSize: 20)
label.pauseInterval = 2
label.scrollDirection = .left
label.scrollSpeed = 20
label.observeApplicationState() // If you want to observe UIApplicationState.
```

### Interface Builder

Set **UIView** to any place and change Custom Class to **ScrollFlowLabel**.

## LICENSE

[ScrollFlowLabel](https://github.com/nnsnodnb/ScrollFlowLabel) is released under the MIT license. See [LICENSE](LICENSE) for details.
