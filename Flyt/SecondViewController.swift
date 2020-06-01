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
    var currentActivity = 0
    
    //MARK: -Activity Sequence
    let activities: [Activity] = [
        .hipRotations,
        .rest,
        .forwardBackwards,
        .rest
    ]
     
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelActivity: UILabel!
    @IBOutlet weak var mainView: UIView!
    
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
        self.mainView.backgroundColor = UIColor(hex: 0x2C1DC4)
        switch activity {
        case .hipRotations:
            motionChecker.handleHipRotation()
        case .forwardBackwards:
            motionChecker.handleForwardBackward()
        case .rest:
            self.mainView.backgroundColor = UIColor(hex: 0x7CB4C4)
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

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

}
