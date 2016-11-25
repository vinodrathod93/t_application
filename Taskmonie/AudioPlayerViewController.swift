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
    
    var urlString: String = ""
    
    let audioPlayer = STKAudioPlayer.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        audioPlayer.play(urlString)
        
        
        
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        audioPlayer.stop()
    }
}
