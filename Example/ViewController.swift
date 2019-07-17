//
//  ViewController.swift
//  Example
//
//  Created by Yuya Oka on 2019/07/17.
//  Copyright © 2019 Yuya Oka. All rights reserved.
//

import UIKit
import ScrollFlowLabel

final class ViewController: UIViewController {

    @IBOutlet private weak var shortFlowLabel: ScrollFlowLabel! {
        didSet {
            shortFlowLabel.text = "Hello World😎"
            shortFlowLabel.textColor = .black
            shortFlowLabel.textAlignment = .left
            shortFlowLabel.font = .systemFont(ofSize: 20)
        }
    }
    @IBOutlet private weak var longFlowLabel: ScrollFlowLabel!
    @IBOutlet private weak var longStackView: UIStackView!

    private lazy var rightFlowLabel: ScrollFlowLabel = {
        let label = ScrollFlowLabel()
        label.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor..."
        label.textColor = .red
        label.textAlignment = .left
        label.font = .italicSystemFont(ofSize: 20)
        label.pauseInterval = 5
        label.scrollDirection = .right
        label.scrollSpeed = 20
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        longStackView.addArrangedSubview(rightFlowLabel)
    }
}
