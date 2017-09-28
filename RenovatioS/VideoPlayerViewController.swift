//
//  VideoPlayerViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/28/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//
import Foundation
import UIKit
import AVKit

class VideoPlayerViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {
    
    func playVideo() {
        if let url = Bundle.main.url(forResource: "video", withExtension: "m4v") {
            player = AVPlayer(url: url)
            player?.play()
        }
        else {
            print("Oops, something wrong when playing video.mp4")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
}
