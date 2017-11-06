//
//  SoundsViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/9/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Material

class MeditationViewController: UIViewController {
    //Step 1 add file Name
    fileprivate var cells: [String] = ["Breath RM", "BodyScanRM", "CandleMeditation Sml"]
    fileprivate var player: AVAudioPlayer?
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTable()
    }
    
    func prepareTable() {
        view.layout(table).top(60).left().right().bottom()
        table.delegate = self
        table.dataSource = self
        table.register(MeditaitonCell.self, forCellReuseIdentifier: "cell")
        table.reloadData()
        table.tableFooterView = UIView()
    }
    
    func preparePlayButton() -> FlatButton {
        let button = FlatButton(title: "Play", titleColor: main)
        button.setTitle("Pause", for: .selected)
        button.setTitle("Play", for: .normal)
        button.pulseColor = main
        return button
    }
    
    func playBreathAction() {
        if player?.isPlaying ?? false {
            player?.stop()
        }
        do {
            let audioURL = Bundle.main.url(forResource: "Breath RM", withExtension: "mp3")
            try player = AVAudioPlayer(contentsOf: audioURL!)
        } catch {
            assertionFailure("Breath RM failed to load")
        }
        player?.prepareToPlay()
        player?.play()
    }
    
    //Step 2 add Action
    func playBodyScanAction() {
        if player?.isPlaying ?? false {
            player?.stop()
        }
        do {
            let audioURL = Bundle.main.url(forResource: "BodyScanRM", withExtension: "mp3")
            try player = AVAudioPlayer(contentsOf: audioURL!)
        } catch {
            assertionFailure("BodyScanRM Failed to load")
        }
        player?.prepareToPlay()
        player?.play()
    }
    
    func playVideo() {
        if player?.isPlaying ?? false {
            player?.stop()
        }
        if let thePlayer = player {
            if thePlayer.isPlaying { thePlayer.stop() }
        }
        player?.stop()
        present(VideoPlayerViewController(), animated: true, completion: nil)
    }
}
extension MeditationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeditaitonCell
        switch indexPath.row {
        case 0:
            cell.label.text = "Breath Meditation"
            cell.artworkImage.image = #imageLiteral(resourceName: "M4IP Album cover")
            
        case 1:
            cell.artworkImage.image = #imageLiteral(resourceName: "M4IP Album cover")
            cell.label.text = "BodyScan Meditation"
        case 2:
            cell.artworkImage.image = #imageLiteral(resourceName: "FrontPage")
            cell.label.text = "Candle Meditation"
        // Step 3: Add new case here
        default:
            cell.label.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if player?.isPlaying ?? false {
            player?.stop()
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.isSelected = false
            tableView.reloadRows(at: [indexPath], with: .none)
            return
        }
        switch indexPath.row {
        case 0:
            playBreathAction()
        case 1:
            playBodyScanAction()
        case 2:
            playVideo()
            // Step 4: call action
        default:
            assertionFailure("Error this cell does not have an action attached to it. Please add one ")
        }
    }
}
