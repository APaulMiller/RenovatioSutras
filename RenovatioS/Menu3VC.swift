//
//  Menu3VC.swift
//  RenovatioS
//
//  Created by Paul Miller on 6/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit

class Menu3VC: UIViewController {

    @IBOutlet var MenuButton: UIBarButtonItem!    
    @IBOutlet var TPOYPwebpage: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        prepareNav()
        
        let url = URL(string: "http://thepowerofyourperceptions.com")
        TPOYPwebpage.loadRequest(URLRequest(url:url!))
    }

    func sideMenus() {
        if revealViewController() != nil {
            MenuButton.target = revealViewController()
            MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 125
            //        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func prepareNav() {
        navigationController?.navigationBar.tintColor = white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //Makes Menu bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
