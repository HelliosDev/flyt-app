//
//  Activity.swift
//  Flyt
//
//  Created by Wendy Kurniawan on 28/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import Foundation

enum Activity : String {
    case hipRotations = "Hip Rotations"
    case forwardBackwards = "Forwards & Backwards"
    case rightLeft = "Right Left Right Left"
    case inOut = "In and Outs"
    case rest = "Rest"
}

extension Activity {
    var instruction: String {
        switch(self){
            case .hipRotations: return "Hip Rotations! hop and twist your hip to the left then change it to the right and repeat."
            case .forwardBackwards: return "Forward Backward! Shift your weight forward and backward, but keep control on your balance"
            case .rightLeft: return "Right Left! Right Foot, Left Foot to the forward, then Right foot, left food to the backward"
            case .inOut: return "In and Out! hop inward then outward while keeping distance between your feet."
            case .rest: return "Rest time!"
        }
    }
}
