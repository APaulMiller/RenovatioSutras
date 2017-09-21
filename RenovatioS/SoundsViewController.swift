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
    private var playButton = FlatButton()
    private var albumArt = UIImageView()
    private var albumTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAudio(file: "Breath RM")
        prepareView()
        preparePlayButton()
    }

    func prepareView() {
        albumArt.image = #imageLiteral(resourceName: "M4IP Album cover")
        view.layout(albumArt).top(80).left(15).width(view.width/3).height(view.width/3)
        albumTitle.text = "Breath Meditation"
        albumTitle.font = UIFont.systemFont(ofSize: 20)
        albumTitle.numberOfLines = 0
        albumTitle.textAlignment = .center
        view.layout(albumTitle).top(90).left(view.width/3 + 25).right(10)
    }
    
    func preparePlayButton(){
        playButton = FlatButton(title: "Play", titleColor: main)
        playButton.setTitle("Pause", for: .selected)
        playButton.setTitle("Play", for: .normal)
        playButton.pulseColor = main
        view.layout(playButton).top(view.width/3).left(view.width/3 + 25).right(10).height(40)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
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
