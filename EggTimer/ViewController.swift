//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = [
        "Soft": 5 * 60 / 60,
        "Medium": 7 * 60 / 60,
        "Hard": 12 * 60 / 60
    ]
    
    var secondsMax: Int = 0
    var secondsRemaining: Int = 0
    var timer = Timer()
    
    var player: AVAudioPlayer!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        progressBar.progress = 1
        titleLabel.text = sender.currentTitle!
        
        secondsMax = eggTimes[sender.currentTitle!]!
        secondsRemaining = eggTimes[sender.currentTitle!]!
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateCounter),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateCounter() {
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
            progressBar.progress = Float(secondsRemaining) / Float(secondsMax)
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            progressBar.progress = 1.0
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
}
