//
//  EzButtonStyle.swift
//
//
//  Created by Dusan Dudukovic on 19.3.24..
//

import Foundation
import UIKit

public enum EzButtonStyle {
    /// Simply define the wanted color of your `EzButton` and let it do its magic!
    case ez(buttonColor: UIColor = .systemBlue, cornerRadius: CGFloat = EzConstants.defaultCornerRadius)
    
    /// Empty background with border.
    case ezSecondary(buttonColor: UIColor = .systemBlue,
                     borderWidth: CGFloat = EzConstants.defaultBorderWidth,
                     cornerRadius: CGFloat = EzConstants.defaultCornerRadius)
    
    public func generateConfiguration() -> EzViewConfiguration {
        switch self {
        case .ez(let color, let radius):
            return EzViewConfiguration(normalState: EzViewState.solidDefault(tintColor: color, cornerRadius: radius),
                                       selectedState: EzViewState.solidDefault(tintColor: color, cornerRadius: radius))
        case .ezSecondary(let color, let borderWidth, let radius):
            return EzViewConfiguration(normalState: EzViewState(borderColor: color,
                                                                backgroundColor: .clear,
                                                                borderWidth: borderWidth,
                                                                cornerRadius: radius),
                                       selectedState: EzViewState(borderColor: color,
                                                                  backgroundColor: .clear,
                                                                  borderWidth: borderWidth,
                                                                  cornerRadius: radius))
        }
    }
    
}
