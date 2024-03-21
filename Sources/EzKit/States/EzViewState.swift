//
//  EzViewState.swift
//  
//
//  Created by Dusan Dudukovic on 12.3.24..
//

import Foundation
import UIKit

// MARK: States
// State variables applied to each state indifferently.
public struct EzViewState {
    
    public let borderColor: UIColor
    public let backgroundColor: UIColor
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    
    public init(borderColor: UIColor, backgroundColor: UIColor,
                borderWidth: CGFloat = EzConstants.defaultBorderWidth,
                cornerRadius: CGFloat = EzConstants.defaultCornerRadius) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}

// MARK: Defaults
extension EzViewState {
    public static let normalDefault = EzViewState(borderColor: .clear,
                                                  backgroundColor: .clear,
                                                  borderWidth: 0,
                                                  cornerRadius: 0)
    
    public static func selectedDefault(tintColor: UIColor = .clear) -> EzViewState {
        return EzViewState(borderColor: tintColor,
                           backgroundColor: tintColor.withAlphaComponent(EzConstants.defaultBackgroundAlpha),
                           borderWidth: EzConstants.defaultBorderWidth,
                           cornerRadius: EzConstants.defaultCornerRadius)
    }
    
    public static func solidDefault(tintColor: UIColor, cornerRadius: CGFloat = EzConstants.defaultCornerRadius) -> EzViewState {
        return EzViewState(borderColor: tintColor,
                           backgroundColor: tintColor,
                           borderWidth: 0,
                           cornerRadius: cornerRadius)
    }
}
