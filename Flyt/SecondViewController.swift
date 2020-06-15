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
    var activityDuration = 0.0
    var restDuration = 0.0
    var seconds = 0.0
    var paused = false
    var initial = true

    let speechService = SpeechService()
    let motionChecker = MotionChecker()
    var currentActivity = 0
    
    //MARK: -Activity Sequence
    let activities: [Activity] = [
        .hipRotations,
//        .rest,
//        .forwardBackwards,
//        .rest,
//        .inOut,
//        .rest,
//        .rightLeft,
//        .rest,
//        .hipRotations,
//        .rest,
//        .forwardBackwards,
//        .rest,
//        .inOut,
//        .rest,
//        .rightLeft
    ]
     
    @IBOutlet weak var imageInstruction: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelActivity: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var popupComplete: UIView!
    @IBOutlet var popupSpirit: UIView!
    @IBOutlet weak var popupNotice: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.layer.cornerRadius = btnStart.frame.height / 2
        seconds = activityDuration
        popupNotice.isHidden = false
        labelActivity.text = self.activities[currentActivity].rawValue
        self.navigationController?.isNavigationBarHidden = false
        imageInstruction.image = UIImage.gif(name: "hip_rotation")
        activityDuration = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let message = "instruction intro".localized
        speechService.say(message)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        speechService.stop()
    }
     
    @IBAction func startAction(_ sender: Any) {
        popupNotice.isHidden = true
        if paused {
            paused = false
            btnStart.setTitle("Start", for: .normal)
            pauseActivity()
        } else {
            paused = true
            btnStart.setTitle("Pause", for: .normal)
            startActivity()
        }
     }

    @objc func updateTimer(){
        seconds -= 1
        labelTimer.text = String(format: "%.0f", seconds)
        if Int(self.seconds) == Int(self.restDuration / 2) && self.currentActivity % 2 != 0 {
            labelActivity.text = "Next Exercise: \n\(self.activities[self.currentActivity + 1].rawValue)"
            switch self.currentActivity {
            case 1:
                imageInstruction.image = UIImage.gif(name: "forward_backward")
            case 3:
                imageInstruction.image = UIImage.gif(name: "right_left")
            case 5:
                imageInstruction.image = UIImage.gif(name: "in_out")
            default:
                break
            }
        }
        if self.seconds == 0 {
            self.currentActivity += 1
            self.stopActivity()
        }
    }
     
    func startActivity() {
        let activity = self.activities[self.currentActivity]
        checkActivity(activity: activity)
        labelActivity.text = activity.rawValue
        initTimer()
    }
     
    private func checkActivity(activity: Activity) {
        if initial && activity != .rest {
            self.seconds = activityDuration
            initial = false
        }
        self.mainView.backgroundColor = UIColor(hex: 0x2C1DC4)
        speechService.say(activity.instruction)
        switch activity {
        case .hipRotations:
            imageInstruction.image = UIImage.gif(name: "hip_rotation")
            motionChecker.handleHipRotation()
        case .forwardBackwards:
            imageInstruction.image = UIImage.gif(name: "forward_backward")
            motionChecker.handleForwardBackward()
        case .rightLeft:
            imageInstruction.image = UIImage.gif(name: "right_left")
            motionChecker.handleRightLeft()
        case .inOut:
            imageInstruction.image = UIImage.gif(name: "in_out")
            motionChecker.handleInOut()
        case .rest:
            self.mainView.backgroundColor = UIColor(hex: 0x7CB4C4)
            imageInstruction.image = UIImage(named: "rest")
            if initial {
                self.seconds = self.restDuration
                initial = false
            }
        }
    }
     
    private func stopActivity() {
        self.timer.invalidate()
        self.motionChecker.stopMotion()
        if currentActivity < self.activities.count {
            initial = true
            startActivity()
        } else {
            showPopup()
        }
    }
    
    func pauseActivity() {
        self.timer.invalidate()
        self.motionChecker.stopMotion()
    }
    
    private func showPopup() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(popupComplete)
        popupComplete.center = self.view.center
    }
    
    private func showAlert() {
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(self.popupSpirit)
            self.popupSpirit.center = self.view.center
        }, completion: nil)

        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.popupSpirit.removeFromSuperview()
        }, completion: nil)
    }

    private func initTimer() {
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

