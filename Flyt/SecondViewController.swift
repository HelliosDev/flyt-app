//
//  SecondViewController.swift
//  Flyt
//
//  Created by Wendy Kurniawan on 29/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var timer = Timer()
    let activityDuration = 10.0
    let restDuration = 5.0
    var seconds = 0.0

    let motionChecker = MotionChecker()
    let activities: [Activity] = [.hipRotations, .rest, .forwardBackwards]
    var currentActivity = 0
     
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelActivity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.layer.cornerRadius = btnStart.frame.height / 2
        seconds = activityDuration
        labelActivity.text = self.activities[currentActivity].rawValue
    }
     
    @IBAction func startAction(_ sender: Any) {
        startActivity()
     }

    @objc func updateTimer(){
        seconds -= 1
        labelTimer.text = String(format: "%.0f", seconds)
    }
     
    func startActivity() {
        let activity = self.activities[self.currentActivity]
        checkActivity(activity: activity)
        labelActivity.text = activity.rawValue
        initTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.currentActivity += 1
            self.stopActivity()
        }
    }
     
    func checkActivity(activity: Activity) {
        self.seconds = activityDuration
        switch activity {
        case .hipRotations:
            motionChecker.handleHipRotation()
        case .forwardBackwards:
            motionChecker.handleForwardBackward()
        case .rest:
            self.seconds = restDuration
        }
    }
     
    func stopActivity() {
        self.timer.invalidate()
        self.motionChecker.stopMotion()
        if currentActivity < self.activities.count {
            startActivity()
        }
    }

    func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

}
