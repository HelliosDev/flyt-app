//
//  secondViewController.swift
//  Flyt
//
//  Created by hafied Khalifatul ash.shiddiqi on 14/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

   var timer: Timer!
   var seconds = 60.00
   
   let timeLabel = UILabel()
   let startButton = UIButton()
   
   
   override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view.
       
       timeLabel.text = "60.00"
       timeLabel.textAlignment = .center
       timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        timeLabel.textColor = UIColor.white
       timeLabel.frame = CGRect(x: self.view.center.x - 75, y: self.view.center.y - 220, width: 150, height: 40)
       self.view.addSubview(timeLabel)
       
       startButton.frame = CGRect(x: view.frame.midX - 125, y: view.frame.midY - 100, width: 250, height: 75)
       
       viewSetUp()
   }
   
   private func viewSetUp(){
       
       
       
       //Time to start customizing the buttons
       
       startButton.backgroundColor = UIColor.black
       startButton.setTitle("START", for: .normal)
       startButton.setTitleColor(.white, for: .normal)
       startButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    startButton.backgroundColor = UIColor(red: 7/255, green: 161/255, blue: 192/255, alpha: 1)
       startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
       startButton.layer.cornerRadius = 20
       
      
       
       
       self.view.addSubview(startButton)
    
       
   }
   
   @objc func startAction(sender: UIButton){
       //What you want to happen when you press the button
       
       timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       
       //This will stop you from starting another timer if one is already running
       startButton.isEnabled = false
   }
   
   @objc func stopAction(sender: UIButton){
       //What you want to happen when you press the button
       
       //Stops Timer
       timer.invalidate()
       
       //You have to make it active once it is no longer running
       startButton.isEnabled = true
   }
   
   @objc func restartAction(sender: UIButton){
       //What you want to happen when you press the button
       
       //Restart will stop the timer and then reset everthing back to normal.
       seconds = 60.00
       timeLabel.text = "60.00"
       timer?.invalidate()
       
       startButton.isEnabled = true
       
   }
   
   @objc func updateTimer(){
       
       //This is to format the string so that it looks all nice :)
       let myTimerFloat = String(format: "%.2f", seconds)
       seconds -= 0.01
       timeLabel.text = myTimerFloat
       
       if seconds <= 0.01{
           //Stops timer
           timer?.invalidate()
           //Set time back to normal.
           seconds = 60.00
           timeLabel.text = "60.00"
       }
       
   }




}
