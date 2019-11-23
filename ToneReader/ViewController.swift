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

    let mic = AKMicrophone()
    var tracker: AKFrequencyTracker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracker = AKFrequencyTracker.init(mic)
        let silence = AKBooster(tracker, gain: 0)
        
        AudioKit.output = silence
        try? AudioKit.start()
        
        let timer = Timer(timeInterval: 0.1, target: self, selector: #selector(readFrequency), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc private func readFrequency()  {
        debugPrint(tracker.frequency)
    }
}

