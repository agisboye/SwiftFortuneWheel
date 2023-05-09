//
//  CAMediaTimingFunction+Curves.swift
//  SwiftFortuneWheel
//
//  Created by August Heegaard on 09/05/2023.
//  
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

extension CAMediaTimingFunction {
    static let easeOutQuart = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
}
