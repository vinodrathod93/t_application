//
//  AudioPlayerViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 27/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import StreamingKit

class AudioPlayerViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    let audioPlayer = STKAudioPlayer.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        audioPlayer.play("http://www.abstractpath.com/files/audiosamples/sample.mp3")
        
        
        
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        audioPlayer.stop()
    }
}
