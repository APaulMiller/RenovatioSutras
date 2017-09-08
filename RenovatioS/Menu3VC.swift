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
        customizeNavBar()
        
        let url = URL(string: "http://thepowerofyourperceptions.com")
        TPOYPwebpage.loadRequest(URLRequest(url:url!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
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
        
               navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
                navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        //Makes Menu bar transparent

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

 }
    

    
}
