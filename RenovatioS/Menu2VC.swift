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

    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBAction func play(_ sender: Any)
    {
    player.play()
    }
 
    @IBAction func pausestop(_ sender: Any)
    {
    player.pause()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()

        do
        {
         let audioPath = Bundle.main.path(forResource: "Breath RM", ofType: "mp3")
         try player = AVAudioPlayer (contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }

        catch
        {
        //Errors to be done at a later date
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet var MenuButton: UIBarButtonItem!
    
    func sideMenus()
    {
        if revealViewController() != nil
        {
            
            MenuButton.target = revealViewController()
            MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 125
            
            //        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func customizeNavBar()
    {
        
        //If not commented out it is white otherwise blue
        
 //       navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
//        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        //Makes Menu bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    

}
