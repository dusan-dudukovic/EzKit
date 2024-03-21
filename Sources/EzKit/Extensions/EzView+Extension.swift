//
//  EzView+Extension.swift
//
//
//  Created by Dusan Dudukovic on 12.3.24..
//

import Foundation
import UIKit

public extension EzView {
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
