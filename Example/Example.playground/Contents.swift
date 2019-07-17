//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ScrollFlowLabel

class ViewController: UIViewController {

    private lazy var scrollFlowLabel: ScrollFlowLabel = {
        let label = ScrollFlowLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor..."
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.pauseInterval = 2
        label.scrollDirection = .left
        label.scrollSpeed = 20
        label.observeApplicationState()
        return label
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(scrollFlowLabel)

        // AutoLayout
        scrollFlowLabel.leftAnchor
            .constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 7)
            .isActive = true
        scrollFlowLabel.centerXAnchor
            .constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0)
            .isActive = true
        scrollFlowLabel.centerYAnchor
            .constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 0)
            .isActive = true

        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = ViewController()
