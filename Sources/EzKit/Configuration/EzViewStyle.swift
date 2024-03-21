//
//  EzViewStyle.swift
//
//
//  Created by Dusan Dudukovic on 12.3.24..
//

import Foundation
import UIKit

/// Simplefied configuration enum. Use `EzViewConfiguration` if you want a more serious interaction with EzView.
public enum EzViewStyle {
    /// Simply define the wanted color and let `EzView` take care of the rest!
    case ez(tintColor: UIColor = .systemBlue)
    
    /// Main way to use `EzView`'s core benefits.
    case main(selectedBorderColor: UIColor, selectedBackgroundColor: UIColor, selectedCornerRadius: CGFloat)
    
    /// Highlighting animation is disabled.
    case selectionOnly(normalState: EzViewState = .normalDefault, selectedState: EzViewState)
    /// Selection animation is disabled.
    case highlightOnly(normalState: EzViewState = .normalDefault, selectedState: EzViewState)
    
    /// Highly customizable, with most of the values available in `EzViewConfiguration`.
    case custom(normalState: EzViewState = .normalDefault,
                selectedState: EzViewState,
                animationDuration: TimeInterval = EzConstants.animationDuration,
                highlightScale: CGFloat = EzConstants.highlightScale,
                selectionScale: CGFloat = EzConstants.selectionScale)
    
    /// Make `EzView` behave like a regular button.
    ///
    /// Use `onSelection` callback or `didSelect` delegate function to detect taps and ignore the bool value they provide.
    case button(state: EzViewState, animateSelection: Bool = true, animateHighlight: Bool = true)
    
    /// Revert me back to the plain and dull `UIView` look. Do you even love me anymore? I will still call-you-back and reach out through a friend though. 
    /// (Callbacks and delegate functions still trigger)
    case none
    
    public func generateConfiguration() -> EzViewConfiguration {
        switch self {
        case .ez(let tintColor):
            return EzViewConfiguration(selectedState: EzViewState.selectedDefault(tintColor: tintColor))
            
        case .main(let selectedBorderColor, let selectedBackgroundColor, let selectedCornerRadius):
            return EzViewConfiguration(selectedState: EzViewState(borderColor: selectedBorderColor,
                                                                  backgroundColor: selectedBackgroundColor,
                                                                  borderWidth: EzConstants.defaultBorderWidth,
                                                                  cornerRadius: selectedCornerRadius))
            
        case .button(let state, let animateSelection, let animateHighlight):
            return EzViewConfiguration(normalState: state, selectedState: state,
                                       highlightAnimationEnabled: animateHighlight, selectionAnimationEnabled: animateSelection)
            
        case .selectionOnly(let normalState, let selectedState):
            return EzViewConfiguration(normalState: normalState,
                                       selectedState: selectedState,
                                       animationDuration: EzConstants.animationDuration * 2,
                                       highlightAnimationEnabled: false)
            
        case .highlightOnly(let normalState, let selectedState):
            return EzViewConfiguration(normalState: normalState,
                                       selectedState: selectedState,
                                       animationDuration: EzConstants.animationDuration * 2,
                                       selectionAnimationEnabled: false)
            
        case .custom(let normalState, let selectedState, let animationDuration, let highlightScale, let selectionScale):
            return EzViewConfiguration(normalState: normalState,
                                       selectedState: selectedState,
                                       animationDuration: animationDuration,
                                       highlightScale: highlightScale,
                                       selectionScale: selectionScale)
            
        case .none:
            return EzViewConfiguration(selectedState: .normalDefault, highlightAnimationEnabled: false, selectionAnimationEnabled: false)
        }
    }
    
}
