//
//  ViewController.swift
//  ToneReader
//
//  Created by Mike on 11/23/19.
//  Copyright © 2019 Mike. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class ViewController: UIViewController, EZMicrophoneDelegate {

    var mic: EZMicrophone!
    @IBOutlet weak var audioPlot: EZAudioPlot!
    
    var lastTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mic = EZMicrophone(delegate: self)
        mic.startFetchingAudio()
        
        audioPlot.backgroundColor = .white
        audioPlot.color = .black
        audioPlot.plotType = .buffer
        audioPlot.shouldMirror = false
        audioPlot.shouldFill = false
    }
}

extension ViewController {
    func microphone(_ microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>?>!, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32, atTime timestamp: UnsafePointer<AudioTimeStamp>!) {
        guard Date().timeIntervalSince(lastTime) > 0.06 else { return }
        lastTime = Date()
        DispatchQueue.main.async {
            self.audioPlot.updateBuffer(buffer[0], withBufferSize: bufferSize)
        }
    }
}
