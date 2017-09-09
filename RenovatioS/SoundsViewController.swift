//
//  SoundsViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/9/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import AVFoundation
import Material

class SoundsViewController: UIViewController {
    private var player: AVAudioPlayer = AVAudioPlayer()
    private var playButton = Button()
    private var albumArt = UIImageView()
    private var albumTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAudio(file: "Breath RM")
        prepareView()
        preparePlayButton()
    }

    func prepareView() {
        albumArt = UIImageView(image: #imageLiteral(resourceName: "MFIP Album Cover"))
        view.layout(albumArt).top(30).left(15).width(view.width/3).height(view.width/3)
        albumTitle.text = "Breath Meditation"
    }
    
    func preparePlayButton(){
        playButton = Button(image: #imageLiteral(resourceName: "cm_pause_white"))
        playButton.setImage(#imageLiteral(resourceName: "cm_play_white"), for: .selected)
    }
    
    func playAction() {
        if player.isPlaying {
            player.pause()
            playButton.isSelected = false
        } else {
            player.play()
            playButton.isSelected = true
        }
    }
    
    func loadAudio(file fileName: String) {
        do {
            let audioPath = Bundle.main.path(forResource: fileName, ofType: "mp3")
            try player = AVAudioPlayer (contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        } catch {
            assertionFailure("Failed to load file")
        }
    }
    
}
