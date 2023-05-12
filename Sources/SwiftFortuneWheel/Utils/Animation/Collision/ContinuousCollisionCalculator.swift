//
//  ContinuousCollisionCalculator.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/29/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Calculates a collision during continuous animation
class ContinuousCollisionCalculator {
    
    /// The time when the last collision accrued
    var lastCollisionTime: CFTimeInterval = 0
    
    /// Interval between collisions
    private var collisionInterval: CFTimeInterval?
    
    /// Current collision index
    private var currentCollisionIndex: Int = 0
    
    /// Rotation degree offset
    var rotationDegreeOffset: CGFloat = 0
    
    /// Calculates collision interval
    /// - Parameters:
    ///   - sliceDegree: Slice degree
    ///   - rotationDegreeOffset: Rotation degree offset
    ///   - fullRotationDegree: Animation full rotation degree
    ///   - speed: Animation speed
    ///   - speedAcceleration: Animation speed acceleration
    func calculateCollisionInterval(sliceDegree: CGFloat, rotationDegreeOffset: CGFloat, fullRotationDegree: CGFloat, speed: CGFloat, speedAcceleration: CGFloat) {
        self.rotationDegreeOffset = rotationDegreeOffset
        collisionInterval = CFTimeInterval(sliceDegree / (fullRotationDegree * speed * speedAcceleration))
    }
    
    /// Calculates collisions
    /// - Parameters:
    ///   - timestamp: Time from the animation begun
    ///   - onCollision: On collision callback
    func calculateCollisionsIfNeeded(timestamp: CFTimeInterval, onCollision: CollisionCallback) {
        guard let collisionInterval = self.collisionInterval else { return }
        
        let interval = currentCollisionIndex == 0 ? collisionInterval - Double(rotationDegreeOffset) : collisionInterval
        
        if lastCollisionTime + interval < timestamp {
            lastCollisionTime = timestamp
            currentCollisionIndex += 1
            onCollision(nil, 0) // FIXME: Rotation angle should be reported
        }
    }
    
    /// Resets parameters
    func reset() {
        collisionInterval = nil
        currentCollisionIndex = 0
    }
}
