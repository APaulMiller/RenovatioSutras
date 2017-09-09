//
//  Menu2VC.swift
//  RenovatioS
//
//  Created by Paul Miller on 6/7/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import AVFoundation

class Menu2VC: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    @IBOutlet var MenuButton: UIBarButtonItem!
    
    @IBAction func play(_ sender: Any) {
        player.play()
    }
 
    @IBAction func pausestop(_ sender: Any) {
        player.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        prepareNavBar()
        loadAudio()
    }

    func loadAudio() {
        do {
            let audioPath = Bundle.main.path(forResource: "Breath RM", ofType: "mp3")
            try player = AVAudioPlayer (contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        } catch {
            assertionFailure("Failed to load file")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            MenuButton.target = revealViewController()
            MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 125
            
            //        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func prepareNavBar() {
        //Makes Menu bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
}
