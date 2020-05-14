//
//  ViewController.swift
//  Flyt
//
//  Created by Wendy Kurniawan on 14/05/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardLevel: UIView!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    private var currentIndex = 0
    private let levels = [
        Level(name: "Beginner", time: 40, description: "7 exercises to give you an agility like flash"),
        Level(name: "Intermediate", time: 75, description: "Ready for a higher challenge? 8 exercises just for you!"),
        Level(name: "Expert", time: 105, description: "A pro? Try all of this on for size!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardLevel.layer.cornerRadius = 8.0
        btnStart.layer.cornerRadius = btnStart.frame.height / 2
        showLevel()
        
    }
    
    private func showLevel() {
        let currentLevel = levels[currentIndex]
        labelLevel.text = currentLevel.name
        labelTime.text = "⏱ \(currentLevel.time) mins"
        labelDescription.text = currentLevel.description
    }

    @IBAction func handlePrev(_ sender: Any) {
        if currentIndex == 0  {
            currentIndex = levels.count - 1
        } else {
            currentIndex -= 1
        }
        showLevel()
    }
    
    @IBAction func handleNext(_ sender: Any) {
        if currentIndex == levels.count - 1  {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        showLevel()
    }
    
    
}

