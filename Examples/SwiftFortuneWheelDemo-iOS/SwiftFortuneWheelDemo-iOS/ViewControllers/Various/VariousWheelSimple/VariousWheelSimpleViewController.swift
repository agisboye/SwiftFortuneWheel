//
//  VariousWheelSimpleViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class VariousWheelSimpleViewController: UIViewController {
    
    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.layer.cornerRadius = centerView.bounds.width / 2
            centerView.layer.borderColor = CGColor.init(srgbRed: CGFloat(256), green: CGFloat(256), blue: CGFloat(256), alpha: 1)
            centerView.layer.borderWidth = 7
        }
    }
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .variousWheelSimpleConfiguration
            wheelControl.slices = slices
            wheelControl.pinImage = "whitePinArrow"
            
            wheelControl.pinImageViewCollisionEffect = CollisionEffect(force: 8, angle: 20)
            
            wheelControl.edgeCollisionDetectionOn = true
            wheelControl.onEdgeCollision = { progress, index in
//                print("Angle: ", progress, " index: ", index)
//                print("edge collision progress: \(String(describing: progress))")
//                var prizes = ["$30", "$10", "$250", "$20", "LOSE", "$5", "$500", "$80", "LOSE", "$200"]
//                print("Current value: \(prizes[prizes.count - 1 - currentSliceIndex])")
                print("Current prize: \(self.prizes[index])")
            }
            
            wheelControl.edgeCollisionSound = AudioFile(filename: "Click", extensionName: "mp3")
        }
    }
    
    var prizes = ["$30", "$10", "$250", "$20", "LOSE", "$5", "$500", "$80", "LOSE", "$200"]
    
    lazy var slices: [Slice] = {
        let slices = prizes.map({ Slice.init(contents: [Slice.ContentType.text(text: $0, preferences: .variousWheelSimpleText)]) })
        return slices
    }()

    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerView.layer.cornerRadius = centerView.bounds.width / 2
    }
    
    @IBAction func rotateTap(_ sender: Any) {
//        wheelControl.startRotationAnimation(finishIndex: finishIndex, continuousRotationTime: 1) { (finished) in
//            print(finished)
//        }
        
        let idx = finishIndex
        print("Winner: \(prizes[idx])")
        
//        self.wheelControl.startRotationAnimation(
//            finishIndex: idx,
//            continuousRotationTime: 5,
//            fullRotationsCount: 20,
//            animationDuration: 15
//        ) { (finished) in
//
////            self.state = .done
//        }
        
        wheelControl.startRotation(finishIndex: idx, continuousTime: 5, speed: 5, decelerationTime: 15, revolutions: 12) { finished in
//            print(finished)
//        }

//        wheelControl.startRotation(finishIndex: idx, continuousTime: 1, speed: 5, decelerationTime: 5, revolutions: 5) { finished in
            print(finished)
        }

//        wheelControl.startRotationAnimation(finishIndex: idx, fullRotationsCount: 13, animationDuration: 15.0) { (finished) in
//            print(finished)
//        }
    }

}
