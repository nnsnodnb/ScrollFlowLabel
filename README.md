# ScrollFlowLabel

[![Swift 5.0.1](https://img.shields.io/badge/language-Swift%205.0.1-orange.svg)](https://developer.apple.com/swift)
![GitHub](https://img.shields.io/github/license/nnsnodnb/ScrollFlowLabel.svg)

![Demo](Resources/ScrollFlowLabelDemo.gif)

Display long text on UILabel while scrolling automatically.

## Installation

### Carthage

```
github "nnsnodnb/ScrollFlowLabel" ~> 1.0.0
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
label.observeNotifications() // If you want to observe UIApplicationState.
```

Please see Example.playground.

## LICENSE

[ScrollFlowLabel](https://github.com/nnsnodnb/ScrollFlowLabel) is released under the MIT license. See [LICENSE](LICENSE) for details.
