//
//  EzView.swift
//  https://github.com/dusan-dudukovic/EzKit
//
//  Created by Dušan Duduković in 2024. Enjoy!
//

import Foundation
import UIKit

// MARK: Delegate
public protocol EzViewDelegate: AnyObject {
    /// Triggered when selection action finishes.
    func didSelect(_ ezView: EzView, isSelected: Bool)
    /// Triggered when highlight action finishes.
    func didHighlight(_ ezView: EzView, isHighlighted: Bool)
    /// Triggered on every animation state change. See properties of `EzAnimationState`.
    func didChangeAnimationState(_ ezView: EzView, state: EzAnimationState)
}

// MARK: Main logic
public class EzView: UIView {
    /// Callback triggered when selection occurs. Use the bool value provided to determine if the view is currently selected or not.
    public var onSelection: ((Bool) -> ())?
    /// Callback triggered when highlighting occurs. Use the bool value provided to determine if the view is currently highlighted or not.
    public var onHighlight: ((Bool) -> ())?
    /// Callback triggered when some of the `EzAnimationState` properties changes.
    public var onAnimationStateChange: ((EzAnimationState) -> ())?
    
    /// Current selection state of the view. You can manually change this value and the state will update according to the configuration values provided (not animated).
    public var isSelected: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    /// Check if the view is currently highlighted. Getter only.
    public var isHighlighted: Bool {
        get {
            return _isHighlighted
        }
    }
    private var _isHighlighted: Bool = false
    
    /// View configuration. Every UI update on the view will apply values from this variable.
    public var configuration: EzViewConfiguration?
    
    // MARK: Helper vars
    private var animationState = EzAnimationState() {
        didSet {
            onAnimationStateChange?(animationState)
            delegate?.didChangeAnimationState(self, state: animationState)
        }
    }
    
    private var animationDuration: TimeInterval {
        return configuration?.animationDuration ?? EzConstants.animationDuration
    }
    private var highlightScale: CGFloat {
        return configuration?.highlightScale ?? EzConstants.highlightScale
    }
    private var selectionScale: CGFloat {
        return configuration?.selectionScale ?? EzConstants.selectionScale
    }
    private var isHighlightEnabled: Bool {
        return configuration?.highlightAnimationEnabled ?? EzConstants.highlightAnimationEnabled
    }
    private var isSelectionEnabled: Bool {
        return configuration?.selectionAnimationEnabled ?? EzConstants.selectionAnimationEnabled
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupGestureRecognizers()
    }
    
    // MARK: Public functions
    /// If you perfer using delegates instead of callbacks, assign a delegate class to this property and handle events there.
    public weak var delegate: EzViewDelegate?
    
    /// Simple configuration. Configure the view's behaviour using `EzViewStyle`. For full configuration, use `configure(configuration: EzViewConfiguration)`.
    public func configure(style: EzViewStyle) {
        self.configuration = style.generateConfiguration()
        updateUI()
    }
    
    /// Advanced configuration. Configure the view's behaviour using `EzViewConfiguration`. For ez configuration, use `configure(style: EzViewStyle)`.
    public func configure(configuration: EzViewConfiguration) {
        self.configuration = configuration
        updateUI()
    }
    
    public func getAnimationState() -> EzAnimationState {
        return animationState
    }
    
    /// This function triggers on every select action (whenever `isSelected` variable changes values).
    /// For custom behavior on selection, override in subclasses and call `super.updateUI()`,
    /// so that the default behavior does not break and add your additional code.
    ///
    /// If you want to remove the default behavior, do not call `super.updateUI()` (not recommended).
    public func updateUI() {
        guard let config = configuration else { return }
        if isSelected {
            layer.borderWidth = config.selectedState.borderWidth
            layer.borderColor = config.selectedState.borderColor.cgColor
            roundCorners(radius: config.selectedState.cornerRadius)
            backgroundColor = config.selectedState.backgroundColor
        } else {
            layer.borderWidth = config.normalState.borderWidth
            layer.borderColor = config.normalState.borderColor.cgColor
            roundCorners(radius: config.normalState.cornerRadius)
            backgroundColor = config.normalState.backgroundColor
        }
    }
}

// MARK: Gestures
extension EzView {
    private func setupGestureRecognizers() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGesture.minimumPressDuration = 0
        longPressGesture.allowableMovement = .infinity
        addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func longPress(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .began:
            highlight()
            
        case .ended:
            let touchLocation = sender.location(ofTouch: 0, in: self)
            if CGRectContainsPoint(self.bounds, touchLocation) {
                select()
            } else {
                cancelHighlight()
            }
        default:
            break
        }
    }
    
    // I decided to go with UILongPressGestureRecognizer because UIScrollView was messing these up pretty badly.
//    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        highlight()
//    }
//    
//    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        
//        if let firstTouch = touches.first {
//            let touchLocation = firstTouch.location(in: self)
//            
//            if CGRectContainsPoint(self.bounds, touchLocation) {
//                select()
//            } else {
//                cancelHighlight()
//            }
//        } else {
//            cancelHighlight()
//        }
//    }
}

extension EzView {
    // MARK: Highlight logic
    private func highlight() {
        guard !animationState.isAnimatingSelection else { return }
        _isHighlighted = true
        
        if isHighlightEnabled == true {
            let currentScale = layer.presentation()?.transform.m11
            
            animationState.isAnimatingHighlight = true
            performScaleAnimation(duration: animationDuration, startScale: currentScale, endScale: highlightScale) { [weak self] in
                self?.animationState.isAnimatingHighlight = false
            }
        }
        
        onHighlight?(isHighlighted)
        delegate?.didHighlight(self, isHighlighted: isHighlighted)
    }
    
    // MARK: Cancel Highlight logic
    private func cancelHighlight() {
        guard !animationState.isAnimatingSelection else { return }
        _isHighlighted = false
        
        if isHighlightEnabled {
            animationState.isAnimatingCancelHighlight = true
            performResetScaleAnimation(duration: cancelHighlightAnimationDuration()) { [weak self] in
                self?.animationState.isAnimatingCancelHighlight = false
            }
        }
        
        onHighlight?(isHighlighted)
        delegate?.didHighlight(self, isHighlighted: isHighlighted)
    }
    
    // MARK: Select logic
    private func select() {
        guard !animationState.isAnimatingSelection else { return }
        isSelected.toggle()
        
        if isSelectionEnabled {
            let resetScaleDuration = cancelHighlightAnimationDuration()
            let selectionCompletion = { [weak self] in
                guard let `self` = self else { return }
                self.animationState.isAnimatingSelection = false
                
                if self.configuration?.triggerSelectionOnAnimationFinish == true {
                    self.onSelection?(self.isSelected)
                    self.delegate?.didSelect(self, isSelected: self.isSelected)
                }
            }
            
            layer.removeAllAnimations()
            
            // animation logic start
            animationState.isAnimatingSelection = true
            if !isHighlighted || !isHighlightEnabled {
                performBounceAnimation(duration: animationDuration, scale: selectionScale) {
                    selectionCompletion()
                }
            } else {
                performResetScaleAnimation(duration: resetScaleDuration) { [weak self] in
                    guard let `self` = self else { return }
                    self.performBounceAnimation(duration: animationDuration, scale: selectionScale) {
                        selectionCompletion()
                    }
                }
            }
            
        } else {
            // if isSelectionEnabled == false, we need to animate scale reset here
            animationState.isAnimatingSelection = true
            performResetScaleAnimation(duration: animationDuration) { [weak self] in
                self?.animationState.isAnimatingSelection = false
            }
        }
        
        _isHighlighted = false
        onHighlight?(isHighlighted)
        delegate?.didHighlight(self, isHighlighted: isHighlighted)
        
        if configuration?.triggerSelectionOnAnimationFinish == false || !isSelectionEnabled {
            onSelection?(isSelected)
            delegate?.didSelect(self, isSelected: isSelected)
        }
    }
}

// MARK: Animations
extension EzView {
    private func performScaleAnimation(duration: TimeInterval, startScale: CGFloat?, endScale: CGFloat, completion: (() -> Void)?) {
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.fromValue = startScale
        animation.toValue = endScale
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        layer.transform = CATransform3DScale(CATransform3DIdentity, endScale, endScale, 1)
        layer.add(animation, forKey: "animateScale")
        CATransaction.commit()
    }
    
    private func performResetScaleAnimation(duration: TimeInterval, completion: (() -> Void)?) {
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "transform.scale")
        let currentScale = layer.presentation()?.transform.m11
        animation.duration = duration
        animation.fromValue = currentScale
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        layer.transform = CATransform3DIdentity
        layer.add(animation, forKey: "animateScale")
        CATransaction.commit()
    }
    
    private func performBounceAnimation(duration: TimeInterval, scale: CGFloat, completion: (() -> Void)?) {
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.fromValue = 1
        animation.toValue = scale
        animation.autoreverses = true
        animation.repeatCount = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        layer.transform = CATransform3DIdentity
        layer.add(animation, forKey: "animateScale")
        CATransaction.commit()
    }
    
    private func cancelHighlightAnimationDuration() -> TimeInterval {
        if let animation = layer.presentation()?.animation(forKey: "animateScale") {
            let elapsedTime = CACurrentMediaTime() - animation.beginTime
            return elapsedTime
        }
        return animationDuration
    }
}
