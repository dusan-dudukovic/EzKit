//
//  EzAnimationState.swift
//
//
//  Created by Dusan Dudukovic on 16.3.24..
//

import Foundation

public struct EzAnimationState {
    public var isAnimatingSelection: ThreadSafeBool
    public var isAnimatingHighlight: Bool
    public var isAnimatingCancelHighlight: Bool
    
    init(isAnimatingSelection: Bool = false, isAnimatingHighlight: Bool = false, isAnimatingCancelHighlight: Bool = false) {
        self.isAnimatingSelection = ThreadSafeBool(isAnimatingSelection)
        self.isAnimatingHighlight = isAnimatingHighlight
        self.isAnimatingCancelHighlight = isAnimatingCancelHighlight
    }
}
