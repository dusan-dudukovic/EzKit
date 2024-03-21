//
//  EzViewConfiguration.swift
//
//
//  Created by Dusan Dudukovic on 12.3.24..
//

import Foundation
import UIKit

/// Core configuration class. Use `EzViewStyle` if you prefer something more casual (just like my ex).
public class EzViewConfiguration {
    
    // MARK: States
    // All possible states.
    /// Properties of this `EzViewState` are applied to the view when it is not selected.
    public var normalState: EzViewState
    /// Properties of this `EzViewState` are applied to the view when it is selected.
    public var selectedState: EzViewState
    
    // MARK: Globals
    /// Applied to a single block of animation only (highlight, cancelHighlight and select).
    ///
    /// Because highlight animation can be interrupted midway (via cancel or select actions), the duration of the next chained animation will be adjusted accordingly.
    /// In this scenario, the highlight cancellation animation will be as long as the highlight animation, rather than the full duration of this property.
    /// See the code in `EzView.cancelHighlightAnimationDuration()` if you want to dive deeper into this logic.
    public var animationDuration: TimeInterval
    
    /// Layer's scale when highlight action completes. Default value is `0.98`.
    public var highlightScale: CGFloat
    /// Layer's furthest scale during selection action. Default value is `1.02`.
    public var selectionScale: CGFloat
    
    /// Determines if the highlight animation will trigger. Default value is `true`. Callback and delegate functions trigger regardless of the value of this property.
    public var highlightAnimationEnabled: Bool
    /// Determines if the selection animation will trigger. Default value is `true`. Callback and delegate functions trigger regardless of the value of this property.
    ///
    /// Note that this boolean affects the bounce animation only, not the block of animation where the scale resets to its initial size after successful selection.
    /// This means that if the highlight animation is enabled, the scale reset will still trigger after selection occurs, even though it could also be considered as a part of "selection".
    /// This is because selection animation currently consists out of 2 parts - reset to initial position and a bounce. Disabling the first part (scale reset) would cause issues.
    /// This is also why you will recieve animation events as `isAnimatingSelection` during scale reset block, even if you set this value to `false`.
    public var selectionAnimationEnabled: Bool
    /// When set to `true`, callbacks and delegate functions will trigger only when the animation is finished.
    ///
    /// Default value is `false`, meaning that the callback/delegate functions will trigger regardless of animation duration.
    public var triggerSelectionOnAnimationFinish: Bool
    
    // MARK: Inits
    /// Simplest init. Uses default values.
    public init(selectedState: EzViewState = .selectedDefault()) {
        self.normalState = .normalDefault
        self.selectedState = selectedState
        self.animationDuration = EzConstants.animationDuration
        self.highlightScale = EzConstants.highlightScale
        self.selectionScale = EzConstants.selectionScale
        self.highlightAnimationEnabled = EzConstants.highlightAnimationEnabled
        self.selectionAnimationEnabled = EzConstants.selectionAnimationEnabled
        self.triggerSelectionOnAnimationFinish = EzConstants.triggerSelectionOnAnimationFinish
    }

    /// Complete init with all possible properties. Read property descriptions within the class for more information.
    public init(normalState: EzViewState = .normalDefault,
                selectedState: EzViewState = .selectedDefault(),
                animationDuration: TimeInterval = EzConstants.animationDuration,
                highlightScale: CGFloat = EzConstants.highlightScale,
                selectionScale: CGFloat = EzConstants.selectionScale,
                highlightAnimationEnabled: Bool = EzConstants.highlightAnimationEnabled,
                selectionAnimationEnabled: Bool = EzConstants.selectionAnimationEnabled,
                triggerSelectionOnAnimationFinish: Bool = EzConstants.triggerSelectionOnAnimationFinish) {
        self.normalState = normalState
        self.selectedState = selectedState
        self.animationDuration = animationDuration
        self.highlightScale = highlightScale
        self.selectionScale = selectionScale
        self.highlightAnimationEnabled = highlightAnimationEnabled
        self.selectionAnimationEnabled = selectionAnimationEnabled
        self.triggerSelectionOnAnimationFinish = triggerSelectionOnAnimationFinish
    }
    
}
