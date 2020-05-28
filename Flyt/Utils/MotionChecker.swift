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
    var pausePhase: Int = 0
    
    //MARK: -Hip Rotation Exercise
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
                let xDown = -1.06 ... -0.9
                let yDown = -0.2 ... 0.17
                let zDown = -0.6 ... -0.05
                
                //MARK: -Condition Phone Holding
                let didHipRotate = xPassing.contains(x) && yPassing.contains(y) && zPassing.contains(z)
                let didHoldDown = xDown.contains(x) && yDown.contains(y) && zDown.contains(z)
                
                if self.motionManager.isAccelerometerActive {
                    if didHoldDown {
                        self.pausePhase += 1
                    } else if didHipRotate {
                        self.pausePhase = 0
                    } else {
                        self.pausePhase += 1
                    }
                } else {
                    self.vibrate()
                }
                
                if self.pausePhase >= 5 {
                    self.self.pausePhase = 0
                    self.vibrate()
                }
            }
        }
    }
    
    //MARK: - Forwards and Backwards Ecercise
    func handleForwardBackward() {
        guard motionManager.isDeviceMotionAvailable else {
            return
        }
        pausePhase = 0
        motionManager.deviceMotionUpdateInterval = 0.5
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (motion, error) in
            if let data = motion {
                //MARK: -Getting Acceleration Data
                let x = data.gravity.x
                let y = data.gravity.y
                let z = data.gravity.z
                   
                //MARK: -Passing Criterias
                let xPassing = -1 ... -0.18
                let yPassing = -0.8 ... 1.7
                let zPassing = -1 ... 0.65
                
                //MARK: -Holding Phone Down Without Doing Anything Criterias
                let xDown = -1 ... -0.6
                let yDown = -0.13 ... 0.25
                let zDown = -0.8 ... -0
                
                //MARK: -Condition Phone Holding
                let didForwardBackward = xPassing.contains(x) && yPassing.contains(y) && zPassing.contains(z)
                let didHoldDown = xDown.contains(x) && yDown.contains(y) && zDown.contains(z)
                
                if self.motionManager.isDeviceMotionActive {
                    if didHoldDown {
                        self.pausePhase += 1
                    } else if didForwardBackward {
                        self.pausePhase = 0
                    } else {
                        self.pausePhase += 1
                    }
                } else if self.motionManager.isAccelerometerActive {
                    self.vibrate()
                } else {
                    self.vibrate()
                }
                
                if self.pausePhase >= 5 {
                    self.self.pausePhase = 0
                    self.vibrate()
                }
            }
        }
    }
    
    private func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(1304))
    }
    
    func stopMotion() {
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }
}
