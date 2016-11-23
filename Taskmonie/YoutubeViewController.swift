//
//  YoutubeViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 13/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import XCDYouTubeKit
//import youtube_ios_player_helper


class YoutubeViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var progressStatusLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playerView: UIView!
    var player: XCDYouTubeVideoPlayerViewController!
    
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
        
//        self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "Quality", style: .Plain, target: self, action: #selector(qualityTapped))
        self.navigationItem.backBarButtonItem   =   UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        
//        let playerVars = ["controls"        : 0,
//                          "playsinline"     : 1,
//                          "autohide"        : 1,
//                          "showinfo"        : 0,
//                          "modestbranding"  : 1,
//                          "rel"             : 0,
//                          "iv_load_policy"  : 3]
//        
//        self.playerView.delegate = self
//        self.playerView.loadWithVideoId(videoID, playerVars: playerVars)
//        
//        
        self.progressView.progress      =   0
        self.title   =   "00:00"
        
        
        
        player  =   XCDYouTubeVideoPlayerViewController.init(videoIdentifier: videoID)
        player.presentInView(self.playerView)
        player.moviePlayer.controlStyle =   .None
//        player.moviePlayer.
        player.moviePlayer.play()
        
        
        
//        loadingIndicatorView.startAnimating()
//        
//        loadingIndicatorView.hidesWhenStopped = true
//        view.addSubview(loadingIndicatorView)
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidecontrol)
//        name:MPMoviePlayerLoadStateDidChangeNotification
//        object:playerView.moviePlayer];
        
        
        self.performSelector(#selector(hideControl), withObject: nil, afterDelay: 1)

//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(hideControl), name: MPMoviePlayerLoadStateDidChangeNotification, object: player.moviePlayer)
        
    }
    
    
    func hideControl() {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerLoadStateDidChangeNotification, object: player.moviePlayer)
        
//        for(id views in [[player view] subviews]){
//            for(id subViews in [views subviews]){
//                for (id controlView in [subViews subviews]){
//                    if ( [controlView isKindOfClass:NSClassFromString(@"MPInlineVideoOverlay")] ) {
//                        [controlView setAlpha:0.0];
//                        [controlView setHidden:YES];
//                    }  
//                }  
//            }  
//        }
        
        
        for views in player.view.subviews {
            for subview in views.subviews {
                for controlView in subview.subviews {
                    if controlView.isKindOfClass(NSClassFromString("MPInlineVideoOverlay")!) {
                        controlView.alpha   =   0.0
                        controlView.hidden  =   true
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loadingIndicatorView.center = CGPoint(x: CGRectGetMidX(view.bounds), y: CGRectGetMidY(view.bounds))
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    // MARK: Youtube Player ios 
    
    
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

    
    
    //MARK: Quality
    
    
    
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
 
 */
}
