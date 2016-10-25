//
//  VideoPlayerViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 24/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

private var playbackLikelyToKeepUpContext = 0

class VideoPlayerViewController: UIViewController {
//    let avPlayerController = AVPlayerViewController()
    
    var avPlayer            =   AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    let invisibleButton = UIButton()
    var timeObserver: AnyObject!
    let timeRemainingLabel = UILabel()
    let progressBar = UIProgressView()
    
    
//    var playerRateBeforeSeek: Float = 0
    let loadingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        
        view.addSubview(invisibleButton)
        invisibleButton.addTarget(self, action: #selector(invisibleButtonTapped),
                                  forControlEvents: .TouchUpInside)
        
        let movieURL:NSURL? = NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")
        
        if let url = movieURL {
            
            let playerItem = AVPlayerItem(URL: url)
            avPlayer.replaceCurrentItemWithPlayerItem(playerItem)
        }
        
        
        let timeInterval: CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeObserver = avPlayer.addPeriodicTimeObserverForInterval(timeInterval,
                                                                   queue: dispatch_get_main_queue()) { (elapsedTime: CMTime) -> Void in
                                                                    
                                                                    
                                                                    self.observeTime(elapsedTime)
        }
        
        timeRemainingLabel.textColor = .whiteColor()
        timeRemainingLabel.font         =   UIFont.systemFontOfSize(20, weight: UIFontWeightBold)
        view.addSubview(timeRemainingLabel)
        
        
        view.addSubview(progressBar)
        
        loadingIndicatorView.hidesWhenStopped = true
        view.addSubview(loadingIndicatorView)
        avPlayer.addObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp",
                             options: .New, context: &playbackLikelyToKeepUpContext)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoPlayerViewController.playerDidFinishPlaying(_:)),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification, object: avPlayer.currentItem)
        
        
    }
    
    
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        
        avPlayerLayer.hidden    =   true
        
        
        let buttonX     =   view.frame.width/2 - 60/2
        let buttonY     =   view.frame.height/2 - 30/2
        
        
        let doneButton = UIButton.init(frame: CGRect.init(x: buttonX, y: buttonY, width: 60, height: 30))
        
        doneButton.setTitle("DONE", forState: .Normal)
        doneButton.layer.borderColor    =   UIColor.whiteColor().CGColor
        doneButton.layer.borderWidth    =   0.5
        doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(doneButton)
        
        
    }

    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?,
                                         change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if context == &playbackLikelyToKeepUpContext {
            if avPlayer.currentItem!.playbackLikelyToKeepUp {
                loadingIndicatorView.stopAnimating()
            } else {
                loadingIndicatorView.startAnimating()
            }
        }
    }
    
    
    deinit {
        avPlayer.removeTimeObserver(timeObserver)
        avPlayer.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingIndicatorView.startAnimating()
        avPlayer.play() // Start the playback
        
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        avPlayer.pause()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Layout subviews manually
        avPlayerLayer.frame = view.bounds
        invisibleButton.frame = view.bounds
        
        let controlsHeight: CGFloat = 30
        let controlsWidth: CGFloat  = 60
        
        let controlX: CGFloat = view.bounds.size.width/2 - controlsWidth/2
        timeRemainingLabel.frame = CGRect(x: controlX, y: 30, width: 60, height: controlsHeight)
        
        
        
        progressBar.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: controlsHeight)
        
        loadingIndicatorView.center = CGPoint(x: CGRectGetMidX(view.bounds), y: CGRectGetMidY(view.bounds))
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    
    func invisibleButtonTapped(sender: UIButton) {
        let playerIsPlaying = avPlayer.rate > 0
        if playerIsPlaying {
            avPlayer.pause()
        } else {
            avPlayer.play()
        }
    }
    
    private func updateTimeLabel(elapsedTime elapsedTime: Float64, duration: Float64) {
        let timeRemaining: Float64 = CMTimeGetSeconds(avPlayer.currentItem!.duration) - elapsedTime
        timeRemainingLabel.text = String(format: "%02d:%02d", ((lround(timeRemaining) / 60) % 60), lround(timeRemaining) % 60)
        
        
        let floatTime = Float(CMTimeGetSeconds(avPlayer.currentTime()))
        let durationTime = Float(duration)
        
        
        progressBar.progress    = floatTime/durationTime
    }
    
    private func observeTime(elapsedTime: CMTime) {
        let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        if isfinite(duration) {
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime: elapsedTime, duration: duration)
        }
    }
    
    
    
    
    func doneButtonTapped(button: UIButton) {
        print(storyboard)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let completeVC = sb.instantiateViewControllerWithIdentifier("videoCompletionVC") as! VideoCompletionViewController
        
        self.navigationController?.pushViewController(completeVC, animated: true)
    }
}
