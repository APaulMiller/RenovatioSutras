//
//  HomeVC.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import Foundation

class HomeVC: UIViewController {
    var index:Int = 0
    var SutraNames:[String] = ["FrontPage", "Awake", "Becoming a Mirror", "Behaviour", "Believing in Ourselves", "Change", "Comfort Zone", "Complacency", "Creating in our Body", "Dead and Buried", "Earth", "Energy", "Experience and Essence", "Faith", "Feeding on our Pain", "Finding a Cure", "Finding Self Worth", "Fire", "Forgiveness", "Giving Your Heart", "Great Awareness", "Greatest Sacrifice", "Growing Your Insights", "Growing your Love", "Heart of God", "Higher Than Forgiveness", "How you are Now", "Iceberg","Inner Peace", "Inside Change", "Inside", "Keep Trying", "Liberation", "Life's Trials", "Limiting Yourself", "Living a Spiritual Life", "Meditation", "Moon and Stars", "Moving Closer to God", "Nail and Blame", "Offence", "Owning your Insights", "Parasite of Judgement", "Reality", "Relaxation", "Resistance", "Sacred Ground", "Stepping out in Faith", "Taking Responsibility","The Universe", "Water", "Who You are Being","Wind","Your Consciousness"]

    var SutraPix = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareImageView()
        NotificationCenter.default.addObserver(self, selector: #selector(pickerpix), name: Notification.Name("pickerused"), object: nil)
    }
    
    func prepareImageView() {
        SutraPix = UIImageView(frame: view.frame)
        view.addSubview(SutraPix)
        let SutraName: String = SutraNames[index]
        SutraPix.image = UIImage(named: SutraName)
    }
    
    func pickerpix () {
        // This is used on returning from the Picker PopOver to select the new Sutra Image
        let SutraName:String = SutraNames[index]
        SutraPix.image = UIImage(named: SutraName)
    }
    
}

//@IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer)
//{
//    GlobalVariables.index = (GlobalVariables.index < GlobalVariables.SutraNames.count-1) ? GlobalVariables.index+1 : 0
//    let newSutraName:String = GlobalVariables.SutraNames[GlobalVariables.index]
//    let NewSutraPix = UIImage(named: newSutraName)!
//    
//    
//    UIView.transition(with: self.SutraPix,
//                      duration: 0.5,
//                      options: .transitionCrossDissolve,
//                      animations: {self.SutraPix.image = NewSutraPix},
//                      completion: nil)
//}
//
//@IBAction func TapToSutraText(_ sender: UITapGestureRecognizer) {
//    
//    performSegue(withIdentifier: "ToSutraText", sender: self)
//    
//    /*        UIView.transition(with: self.SutraPix,
//     duration: 0.5,
//     options: .transitionCrossDissolve,
//     animations: {SutraTextVC.self},
//     */
//    
//}


//Show PopUP
//@IBAction func SwipeDown(_ sender: UISwipeGestureRecognizer) {
//    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PickerVC
//    self.addChildViewController(popOverVC)
//    popOverVC.view.frame = self.view.frame
//    self.view.addSubview(popOverVC.view)
//    popOverVC.didMove(toParentViewController: self)
//}
