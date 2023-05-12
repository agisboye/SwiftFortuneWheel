//
//  CollisionCalculator.swift
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

/// Calculates collision during the animation
class CollisionCalculator {
    
    /// Collisions start positions
    private var collisionDegrees: [Double] = []
    
    /// Current collision index
    private var currentCollisionIndex: Int = 0
    
    /// 360 degrees of rotation count
    private var rotationCount: Int = 0
    
    /// Total rotation degree
    private var totalRotationDegree: Double = 0
    
    /// Last rotation degree
    private var lastRotationDegree: Double?
    
    /// Rotation direction offset
    private var rotationDirectionOffset: CGFloat {
        #if os(macOS)
        return -1
        #else
        return 1
        #endif
    }
    
    /// Size of each slice (in degrees)
    private var sliceDegree: CGFloat = 0
    
    /// Rotation degree offset
    private var rotationDegreeOffset: CGFloat = 0
    
    /// Calculates collisions start positions
    /// - Parameters:
    ///   - sliceDegree: Slice degree
    ///   - rotationDegreeOffset: Rotation degree offset
    ///   - rotationDegree: Animation full rotation degree
    ///   - animationDuration: Animation duration time
    func calculateCollisionDegrees(sliceDegree: CGFloat, rotationDegreeOffset: CGFloat, rotationDegree: CGFloat, animationDuration: CFTimeInterval) {
        
        let sectorsCount = (rotationDegree / sliceDegree)
        
        for index in 0..<Int(sectorsCount) {
            let degree = (rotationDegreeOffset + (CGFloat(index) * sliceDegree))
            collisionDegrees.append(Double(degree))
        }
        
        self.sliceDegree = sliceDegree
        self.rotationDegreeOffset = rotationDegreeOffset
    }
    
    /// Calculates collisions if needed
    /// - Parameters:
    ///   - layerRotationZ: Animation layer rotation Z position
    ///   - onCollision: On collision callback
    func calculateCollisionsIfNeeded(layerRotationZ: Double?, onCollision: CollisionCallback) {
        // Return if collisionDegrees is empty
        guard collisionDegrees.count > 0 else { return }
        // Return if layerRotationZ is nil
        guard let rotationZ = layerRotationZ else { return }
        // Return if all collisions are calculated
        guard currentCollisionIndex < collisionDegrees.count else { return }
        
        // The layer's rotated offset value converted to degree
        let rotationOffset = rotationZ * Double(rotationDirectionOffset) * 180.0 / .pi
        
        // Current rotation position of the layer
        let currentRotationDegree = rotationOffset >= 0 ? rotationOffset : 360 + rotationOffset
        
        // Total rotation degree of the layer
        totalRotationDegree = Double(rotationCount * 360) + currentRotationDegree
        
        var latestProgress: Double?
        
        // Determine which of the collision degrees have been passed since the last updated.
        // Progress is reported for the last collision that occurred
        for collisionDegree in collisionDegrees[currentCollisionIndex..<collisionDegrees.count] {
            if collisionDegree < totalRotationDegree {
                // Update current collision progress
                latestProgress = Double(currentCollisionIndex) / Double(collisionDegrees.count)
                
                // Advance current index
                currentCollisionIndex += 1
            } else {
                break
            }
        }
        
        if currentCollisionIndex >= collisionDegrees.count {
            latestProgress = 1
        }
        
        if let latestProgress {
            // Callback collision if needed with progress
            onCollision(latestProgress, currentRotationDegree)
        }
        
        // If the previous rotation degree is more than current, then the layer is rotated more than 360 degree
        if lastRotationDegree ?? 0 > currentRotationDegree {
            rotationCount += 1
        }
        
        // Remembers last rotation degree, used to correctly calculate total rotation degree
        lastRotationDegree = currentRotationDegree
    }
    
    /// Resets parameters
    func reset() {
        collisionDegrees = []
        currentCollisionIndex = 0
        rotationCount = 0
        totalRotationDegree = 0
        lastRotationDegree = nil
        sliceDegree = 0
        rotationDegreeOffset = 0
    }
}
