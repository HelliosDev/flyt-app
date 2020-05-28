//
//  secondViewController.swift
//  Flyt
//
//  Created by hafied Khalifatul ash.shiddiqi on 14/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import UIKit
import AudioToolbox

class SecondViewController: UIViewController {

    var timer = Timer()
    var seconds = 60.0
    var rest = false
    var isPaused = false

    let motionChecker = MotionChecker()
   
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var labelTimer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.layer.cornerRadius = btnStart.frame.height / 2
        
   }
    
    @IBAction func startAction(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        motionChecker.handleForwardBackward()
        
//        if !rest {
//            startActivity(activity: Activity.hipRotations)
//        } else {
//            startRest(time: 20.0)
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.stopActivity()
        }
    }
   
    @objc func updateTimer(){
        seconds -= 1
        labelTimer.text = String(format: "%.0f", seconds)
    }
    
    func startActivity(activity: Activity) {
        switch activity {
        case .hipRotations:
            motionChecker.handleHipRotation()
        case .forwardBackwards:
            motionChecker.handleForwardBackward()
        }
    }
    
    func stopActivity() {
        self.timer.invalidate()
        self.motionChecker.stopMotion()
    }
    
    func startRest(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.timer.invalidate()
            self.startActivity(activity: Activity.forwardBackwards)
        }
    }
}
