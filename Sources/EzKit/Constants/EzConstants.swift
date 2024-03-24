//
//  EzConstants.swift
//  
//
//  Created by Dusan Dudukovic on 12.3.24..
//

import Foundation
import UIKit

/// Default values applied when they are not set through configuration/style.
public struct EzConstants {
    public static let defaultBackgroundAlpha: CGFloat = 0.08
    public static let defaultBorderWidth: CGFloat = 1
    public static let defaultCornerRadius: CGFloat = 0
    
    public static let animationDuration: TimeInterval = 0.05
    public static let highlightScale: CGFloat = 0.98
    public static let selectionScale: CGFloat = 1.02
    public static let highlightAnimationEnabled: Bool = true
    public static let selectionAnimationEnabled: Bool = true
    public static let triggerSelectionOnAnimationFinish: Bool = false
}
