//
//  CoreMotionViewController.swift
//  Flyt
//
//  Created by Ivan Winata on 20/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import UIKit
import CoreMotion

class CoreMotionViewController: UIViewController {

    
    let motionManager = CMMotionManager()
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var lblDone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!)
        {
                   (data, eror) in
                   if let myData = data {
                       print(myData)
                    if myData.acceleration.x > 0.8
                    {
                           self.lblDone.text = "Done!"
                    //       self.lblDone.textColor =
                           self.lblInstruction.text = "Now move to the left!"
                    }else if myData.acceleration.x < -0.8
                    {
                           self.lblDone.text = "true"
                           self.lblInstruction.text = "Now move to thr right!"
                       }
                   }
               }
               
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
