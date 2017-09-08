//
//  ViewController.swift
//  RenovatioS
//
//  Created by Paul Miller on 6/7/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct GlobalVariables {
        static var index:Int = 0
        
        static var SutraNames:[String] = ["FrontPage", "asleep", "Becoming a Mirror", "Behaviour", "Believing in Ourselves", "Change", "Comfort Zone", "Complacency", "Creating in our Body", "Dead and Buried", "Earth", "Energy", "Experience and Essence", "Faith", "Feeding on our Pain", "Finding a Cure", "Finding Self Worth", "Fire", "Forgiveness", "Giving Your Heart", "Great Awareness", "Greatest Sacrifice", "Growing Your Insights", "Growing your Love", "Heart of God", "Higher Than Forgiveness", "How you are Now", "Iceberg","Inner Peace", "Inside Change", "Inside", "Keep Trying", "Liberation", "Life's Trials", "Limiting Yourself", "Living a Spiritual Life", "Meditation", "Moon and Stars", "Moving Closer to God", "Nail and Blame", "Offence", "Owning your Insights", "Parasite of Judgement", "Reality", "Relaxation", "Resistance", "Sacred Ground", "Stepping out in Faith", "Taking Responsibility","The Universe", "Water", "Who You are Being","Wind","Your Consciousness"]
    }
     
    

    @IBOutlet var SutraPix: UIImageView!
    
    @IBOutlet var MenuButton: UIBarButtonItem!

    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer)
    {
        GlobalVariables.index = (GlobalVariables.index != 0) ? GlobalVariables.index-1 : 0
        let newSutraName:String = GlobalVariables.SutraNames[GlobalVariables.index]
        let NewSutraPix = UIImage(named: newSutraName)!

        
       UIView.transition(with: self.SutraPix,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {self.SutraPix.image = NewSutraPix},
                         completion: nil)
    }
    
    
    
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer)
    {
        GlobalVariables.index = (GlobalVariables.index < GlobalVariables.SutraNames.count-1) ? GlobalVariables.index+1 : 0
        let newSutraName:String = GlobalVariables.SutraNames[GlobalVariables.index]
        let NewSutraPix = UIImage(named: newSutraName)!
        
        
        UIView.transition(with: self.SutraPix,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {self.SutraPix.image = NewSutraPix},
                          completion: nil)
    }

    @IBAction func TapToSutraText(_ sender: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "ToSutraText", sender: self)
        
/*        UIView.transition(with: self.SutraPix,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {SutraTextVC.self},
 */
        
    }


    func pickerpix ()
    {
        // This is used on returning from the Picker PopOver to select the new Sutra Image
        let SutraName:String = GlobalVariables.SutraNames[GlobalVariables.index]
        SutraPix.image = UIImage(named: SutraName)
    }

    
    //Show PopUP
    @IBAction func SwipeDown(_ sender: UISwipeGestureRecognizer)
    {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PickerVC
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

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
        
        //Makes menu icon white
        
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        //Makes Menu bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        customizeNavBar()
        
        let SutraName:String = GlobalVariables.SutraNames[GlobalVariables.index]
        SutraPix.image = UIImage(named: SutraName)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pickerpix), name: Notification.Name("pickerused"), object: nil)


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

