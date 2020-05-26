//
//  MotionChecker.swift
//  Flyt
//
//  Created by Wendy Kurniawan on 26/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import Foundation
import CoreMotion
import AudioToolbox

class MotionChecker {
    let motionManager = CMMotionManager()
    var pausePhase = 0
    func handleHipRotation() {
        guard motionManager.isAccelerometerAvailable else {
            return
        }
        pausePhase = 0
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accData, error) in
            if let data = accData {
                //MARK: -Getting Acceleration Data
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z
                   
                //MARK: -Passing Criterias
                let xPassing = -3.5 ... -0.4
                let yPassing = -3.2 ... 2.2
                let zPassing = -1.9 ... 1.5
                
                //MARK: -Holding Phone Down Without Doing Anything Criterias
                let xDown = -1.06 ... -0.84
                let yDown = -0.2 ... 0.17
                let zDown = -0.51 ... -0.08
                
                //MARK: -Condition Phone Holding
                let didHipRotate = xPassing.contains(x) && yPassing.contains(y) && zPassing.contains(z)
                let didHoldDown = xDown.contains(x) && yDown.contains(y) && zDown.contains(z)
                
                if didHoldDown {
                    self.pausePhase += 1
                } else if didHipRotate {
                    self.pausePhase = 0
                } else {
                    self.pausePhase += 1
                }
                
                if self.pausePhase >= 5 {
                    self.self.pausePhase = 0
                    self.vibrate()
                }
            }
        }
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(1304))
    }
    
    func stopMotion() {
        motionManager.stopAccelerometerUpdates()
    }
}
