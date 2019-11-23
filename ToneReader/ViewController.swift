//
//  ViewController.swift
//  ToneReader
//
//  Created by Mike on 11/23/19.
//  Copyright © 2019 Mike. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var oscillator = AKOscillator()
    var oscillator2 = AKOscillator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioKit.output = AKMixer(oscillator, oscillator2)
        AKSettings.playbackWhileMuted = true
        try? AudioKit.start()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if oscillator.isPlaying {
            oscillator.stop()
        } else {
            oscillator.amplitude = random(in: 0.5...1)
            oscillator.frequency = random(in: 220...880)
            oscillator.start()
        }
    }
}

