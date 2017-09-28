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

class SoundsViewController: UIViewController {
    fileprivate var cells: [String] = []
    fileprivate var table: TableView = TableView()
    fileprivate var player: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add file name here
        cells = ["Breath RM", "Video"]
        prepareTable()
    }
    
    func prepareTable(){
        table = TableView(frame: view.frame)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.layout(table).top(20).left().right().bottom()
    }
    
    func preparePlayButton() -> FlatButton {
        let button = FlatButton(title: "Play", titleColor: main)
        button.setTitle("Pause", for: .selected)
        button.setTitle("Play", for: .normal)
        button.pulseColor = main
        button.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        return button
    }
    
    func playAction() {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func loadAudio(file fileName: String) {
        do {
            let audioURL = Bundle.main.url(forResource: fileName, withExtension: "mp3")
            try player = AVAudioPlayer(contentsOf: audioURL!)
        } catch {
            assertionFailure("Failed to load file")
        }
    }
    
    func prepareVideoButton() -> FlatButton {
        let button = FlatButton(title: "Play Video", titleColor: main)
        button.setTitle("Pause Video", for: .selected)
        button.setTitle("Play Video", for: .normal)
        button.pulseColor = main
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        return button
    }
    
    func playVideo() {
        //Stop any Audio tracks before going to the video player.
        if player.isPlaying {
            player.pause()
        }
        present(VideoPlayerViewController(), animated: true, completion: nil)
    }
    
}

extension SoundsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.width/2, height: view.width/2))
        let label = UILabel()
        let type = cells[indexPath.row]
        cell.selectionStyle = .none
        cell.layout(imageView).top(80).left(15).width(view.width/3).height(view.width/3)
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        cell.layout(label).top(90).left(view.width/3 + 25).right(10)
        var button = FlatButton()
        
        switch type {
        case "Breath RM":
            imageView.image = #imageLiteral(resourceName: "M4IP Album cover")
            label.text = "Breath Meditation"
            loadAudio(file: "Breath RM")
            button = preparePlayButton()
        case "Video":
            imageView.image = #imageLiteral(resourceName: "FrontPage")
            label.text = "Video.m4v"
            button = prepareVideoButton()
            // Add new case here
        default:
            imageView.image = UIImage()
            label.text = ""
        }
        
        cell.layout(button).top(view.width/3).left(view.width/3 + 25).right(10).height(60)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
}
