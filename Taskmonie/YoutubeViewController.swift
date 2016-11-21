//
//  YoutubeViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 13/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class YoutubeViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var progressStatusLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playerView: YTPlayerView!
    
    let videoID: String =   "X84IVKm8x6M"
    
    let loadingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .blackColor()
        
        doneButton.layer.borderColor    =   UIColor.whiteColor().CGColor
        doneButton.layer.borderWidth    =   0.5
        doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), forControlEvents: .TouchUpInside)
        doneButton.hidden = true
        
        self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "Quality", style: .Plain, target: self, action: #selector(qualityTapped))
        self.navigationItem.backBarButtonItem   =   UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        
        let playerVars = ["controls"        : 0,
                          "playsinline"     : 1,
                          "autohide"        : 1,
                          "showinfo"        : 0,
                          "modestbranding"  : 1,
                          "rel"             : 0,
                          "iv_load_policy"  : 3]
        
        self.playerView.delegate = self
        self.playerView.loadWithVideoId(videoID, playerVars: playerVars)
        
        
        self.progressView.progress      =   0
        self.title   =   "00:00"
        
        loadingIndicatorView.startAnimating()
        
        loadingIndicatorView.hidesWhenStopped = true
        view.addSubview(loadingIndicatorView)
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loadingIndicatorView.center = CGPoint(x: CGRectGetMidX(view.bounds), y: CGRectGetMidY(view.bounds))
    }
    
    func qualityTapped() {
        let alertController = UIAlertController.init(title: "", message: "", preferredStyle: .ActionSheet)
        
        let small = UIAlertAction.init(title: "240p", style: .Default) { (_) in
            
            self.playerView.loadVideoById(self.videoID, startSeconds: self.playerView.currentTime(), suggestedQuality: .Small)
            
            self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "240p", style: .Plain, target: self, action: #selector(self.qualityTapped))
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        let medium = UIAlertAction.init(title: "360p", style: .Default) { (_) in
            
            self.playerView.loadVideoById(self.videoID, startSeconds: self.playerView.currentTime(), suggestedQuality: .Medium)
            self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "360p", style: .Plain, target: self, action: #selector(self.qualityTapped))
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        
        let large = UIAlertAction.init(title: "480p", style: .Default) { (_) in
            
            self.playerView.loadVideoById(self.videoID, startSeconds: self.playerView.currentTime(), suggestedQuality: .Large)
            self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "480p", style: .Plain, target: self, action: #selector(self.qualityTapped))
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let hd720 = UIAlertAction.init(title: "720p", style: .Default) { (_) in
            
            self.playerView.loadVideoById(self.videoID, startSeconds: self.playerView.currentTime(), suggestedQuality: .HD720)
            self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "720p", style: .Plain, target: self, action: #selector(self.qualityTapped))
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let hd1080 = UIAlertAction.init(title: "1080p", style: .Default) { (_) in
            
            self.playerView.loadVideoById(self.videoID, startSeconds: self.playerView.currentTime(), suggestedQuality: .HD1080)
            self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "1080p", style: .Plain, target: self, action: #selector(self.qualityTapped))
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .Cancel) { (_) in
            
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        
        alertController.addAction(small)
        alertController.addAction(medium)
        alertController.addAction(large)
        alertController.addAction(hd720)
        alertController.addAction(hd1080)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playerViewDidBecomeReady(playerView: YTPlayerView) {
        
        loadingIndicatorView.stopAnimating()
        playerView.playVideo()
        
        print(playerView.availableQualityLevels()?.description)
        print(playerView.playbackQuality().rawValue)
    }

    func playerView(playerView: YTPlayerView, didPlayTime playTime: Float) {
        
        
        let currentTime = NSTimeInterval(playTime)
        
        let progress = playTime/Float(self.playerView.duration())
        
        progressView.progress   =   progress
        self.title    =  stringFromTimeInterval(currentTime) + "/" + stringFromTimeInterval(self.playerView.duration())
    }
    
    
    func playerView(playerView: YTPlayerView, didChangeToState state: YTPlayerState) {
        
        print(state.rawValue)
        
        switch state {
            
        case .Unstarted:
            self.playerView.playVideo()
            
        case .Ended:
            doneButton.hidden   =   false
            playerView.hidden   =   true
            
        default: break

        }
    }

    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    
    func doneButtonTapped(button: UIButton) {
        print(storyboard)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let completeVC = sb.instantiateViewControllerWithIdentifier("videoCompletionVC") as! VideoCompletionViewController
        
        self.navigationController?.pushViewController(completeVC, animated: true)
    }

}
