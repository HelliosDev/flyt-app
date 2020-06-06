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
    @IBOutlet weak var levelPageControl: UIPageControl!
    @IBOutlet weak var btnStart: UIButton!
    
    private var currentIndex = 0
    private let levels = [
        Level(name: "Beginner", time: 30, description: "Beginning for flashy agility"),
        Level(name: "Intermediate", time: 60, description: "Ready for a higher challenge?"),
        Level(name: "Expert", time: 90, description: "A pro? Try all of this on for size!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardLevel.layer.cornerRadius = 8.0
        btnStart.layer.cornerRadius = btnStart.frame.height / 2
        levelPageControl.numberOfPages = levels.count
        
        showLevel()
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        showNext()
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        showPrev()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SecondViewController {
            let vc = segue.destination as? SecondViewController
            let currentLevel = levels[currentIndex]
            vc?.activityDuration = (8.0 / 15.0 * Double(currentLevel.time * 60)).rounded()
            vc?.restDuration = (7.0 / 15.0 * Double(currentLevel.time * 60)).rounded()
        }
    }
    
    private func showLevel() {
        let currentLevel = levels[currentIndex]
        levelPageControl.currentPage = currentIndex
        labelLevel.text = currentLevel.name
        labelTime.text = "⏱ \(currentLevel.time) mins"
        labelDescription.text = currentLevel.description
    }
    
    private func showPrev() {
        if currentIndex == 0  {
            currentIndex = levels.count - 1
        } else {
            currentIndex -= 1
        }
        showLevel()
    }
    
    private func showNext() {
        if currentIndex == levels.count - 1  {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        showLevel()
    }
}

