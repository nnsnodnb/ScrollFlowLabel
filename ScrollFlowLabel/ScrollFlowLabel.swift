//
//  ScrollFlowLabel.swift
//  ScrollFlowLabel
//
//  Created by Yuya Oka on 2019/07/15.
//  Copyright © 2019 Yuya Oka. All rights reserved.
//

import UIKit

@IBDesignable
public class ScrollFlowLabel: UIView {

    @objc public enum ScrollDirection: Int {
        case left
        case right
    }

    // MARK: - Changeable Properties

    @IBInspectable public var scrollSpeed: CGFloat = 30 { // default is 30.
        didSet {
            updateScrollLabelIfNeeded()
        }
    }
    @IBInspectable public var pauseInterval: Double = 1.5 // default is 1.5.
    @IBInspectable public var labelSpacing: UInt = 20 // default is 20.
    @IBInspectable public var fadeLength: CGFloat = 7 { // default is 7.
        didSet {
            if oldValue == fadeLength { return }
            refresh()
            applyGradientMask(for: fadeLength, enableFade: false)
        }
    }
    @IBInspectable public var text: String? {
        get {
            return mainLabel.text
        }
        set {
            labels.forEach { $0.text = newValue }
            refresh()
        }
    }
    @IBInspectable public var textColor: UIColor {
        get {
            return mainLabel.textColor
        }
        set {
            labels.forEach { $0.textColor = newValue }
        }
    }
    @IBInspectable public var shadowColor: UIColor? {
        get {
            return mainLabel.shadowColor
        }
        set {
            labels.forEach { $0.shadowColor = newValue }
        }
    }
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return mainLabel.shadowOffset
        }
        set {
            labels.forEach { $0.shadowOffset = newValue }
        }
    }

    public var attributedText: NSAttributedString? {
        get {
            return mainLabel.attributedText
        }
        set {
            labels.forEach { $0.attributedText = newValue }
            refresh()
        }
    }
    public var textAlignment: NSTextAlignment = .left
    public var font: UIFont {
        get {
            return mainLabel.font
        }
        set {
            labels.forEach { $0.font = newValue }
            refresh()
            invalidateIntrinsicContentSize()
        }
    }
    public var scrollDirection: ScrollDirection = .left {
        didSet {
            updateScrollLabelIfNeeded()
        }
    }
    public var animationOptions: UIView.AnimationOptions = [.curveLinear]

    // MARK: - Private Property

    private var scrolling: Bool = false

    // MARK: - Get Only Private Properties

    private lazy var labels: [UILabel] = {
        return (0..<2).map { _ in
            let label = UILabel()
            label.backgroundColor = .clear
            label.autoresizingMask = autoresizingMask
            scrollView.addSubview(label)
            return label
        }
    }()
    private lazy var scrollView: UIScrollView! = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        addSubview(scrollView)
        return scrollView
    }()

    private var mainLabel: UILabel! {
        return labels.first!
    }

    // MARK: - Override Properties

    public override var frame: CGRect {
        didSet {
            refresh()
            applyGradientMask(for: fadeLength, enableFade: scrolling)
        }
    }

    public override var bounds: CGRect {
        didSet {
            refresh()
            applyGradientMask(for: fadeLength, enableFade: scrolling)
        }
    }

    // MARK: - Override Method

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil { updateScrollLabelIfNeeded() }
    }

    public override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: mainLabel.intrinsicContentSize.height)
    }

    // MARK: - Initializer

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Life Cycle

    deinit {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Public Method

public extension ScrollFlowLabel {

    func observeApplicationState() {
        NotificationCenter.default.removeObserver(self)

        NotificationCenter.default.addObserver(self, selector: #selector(receiveWillEnterForegroundNotification(_:)),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDidBecomeActiveNotification(_:)),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

// MARK: - Private Method

private extension ScrollFlowLabel {

    func commonInit() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
        clipsToBounds = true
    }

    func refresh() {
        var offset: CGFloat = 0

        labels.forEach { label in
            label.sizeToFit()
            var frame = label.frame
            frame.origin = .init(x: offset, y: 0)
            frame.size.height = bounds.height
            label.frame = frame

            label.center = .init(x: label.center.x, y: round(center.y - self.frame.minY))

            offset += label.bounds.width + CGFloat(labelSpacing)
        }

        scrollView.contentOffset = .zero
        scrollView.layer.removeAllAnimations()

        if mainLabel.bounds.width > bounds.width {
            let width = mainLabel.bounds.width + bounds.width + CGFloat(labelSpacing)
            scrollView.contentSize = .init(width: width, height: bounds.height)

            labels.forEach { $0.isHidden = false }

            applyGradientMask(for: fadeLength, enableFade: scrolling)

            updateScrollLabelIfNeeded()
        } else {
            labels.forEach { $0.isHidden = (mainLabel != labels.last) }

            scrollView.contentSize = bounds.size
            mainLabel.frame = bounds
            mainLabel.isHidden = false
            mainLabel.textAlignment = textAlignment

            scrollView.layer.removeAllAnimations()

            applyGradientMask(for: 0, enableFade: false)
        }
    }

    private func applyGradientMask(for fadeLength: CGFloat, enableFade isEnabled: Bool) {
        let labelWidth = mainLabel.bounds.width

        if labelWidth <= bounds.width {
            layer.mask = nil
            return
        }

        let gradient = CAGradientLayer()
        gradient.bounds = layer.bounds
        gradient.position = .init(x: bounds.midX, y: bounds.midY)
        gradient.shouldRasterize = true
        gradient.rasterizationScale = UIScreen.main.scale
        gradient.startPoint = .init(x: 0, y: frame.midY)
        gradient.endPoint = .init(x: 1, y: frame.midY)

        let transparent = UIColor.clear.cgColor
        let opaque = UIColor.black.cgColor
        gradient.colors = [transparent, opaque, opaque, transparent]

        let fadePoint = fadeLength / bounds.width
        var leftFadePoint: NSNumber = .init(value: Float(fadePoint))
        var rightFadePoint: NSNumber = .init(value: Float(1 - fadePoint))

        defer {
            gradient.locations = [0, leftFadePoint, rightFadePoint, 1]

            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.mask = gradient
            CATransaction.commit()
        }

        if isEnabled { return }
        switch scrollDirection {
        case .left:
            leftFadePoint = 0
        case .right:
            leftFadePoint = 0
            rightFadePoint = 1
        }
    }

    @objc private func enableShadow() {
        scrolling = true
        applyGradientMask(for: fadeLength, enableFade: scrolling)
    }

    @objc private func updateScrollLabelIfNeeded() {
        if let text = text, text.isEmpty { return }

        let labelWidth = mainLabel.bounds.width
        if labelWidth <= bounds.width { return }

        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(updateScrollLabelIfNeeded),
                                               object: nil)
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(enableShadow),
                                               object: nil)

        scrollView.layer.removeAllAnimations()

        switch scrollDirection {
        case .left:
            scrollView.contentOffset = .zero
        case .right:
            scrollView.contentOffset = .init(x: labelWidth + CGFloat(labelSpacing), y: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + pauseInterval) { [weak self] in
            self?.enableShadow()
        }

        let duration = CGFloat(labelWidth) / scrollSpeed
        let options: UIView.AnimationOptions = [animationOptions, .allowUserInteraction]

        UIView.animate(
            withDuration: TimeInterval(duration), delay: pauseInterval, options: options,
            animations: { [unowned self] in
                switch self.scrollDirection {
                case .left:
                    self.scrollView.contentOffset = .init(x: labelWidth + CGFloat(self.labelSpacing), y: 0)
                case .right:
                    self.scrollView.contentOffset = .zero
                }
            }, completion: { [weak self] finished in
                guard let wself = self else { return }
                wself.scrolling = false

                wself.applyGradientMask(for: wself.fadeLength, enableFade: false)

                if !finished { return }
                wself.updateScrollLabelIfNeeded()
            }
        )
    }
}

// MARK: - NotificationCenter target

extension ScrollFlowLabel {

    @objc private func receiveWillEnterForegroundNotification(_ notification: Notification) {
        updateScrollLabelIfNeeded()
    }

    @objc private func receiveDidBecomeActiveNotification(_ notification: Notification) {
        updateScrollLabelIfNeeded()
    }
}
