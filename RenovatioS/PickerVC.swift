////
////  PickerVC.swift
////  RenovatioS
////
////  Created by Paul Miller on 6/8/17.
////  Copyright © 2017 TPOYP. All rights reserved.
////
//
//import UIKit
//
//class PickerVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
//
//    @IBOutlet var SelectSutra: UIPickerView!
// 
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
//        self.showAnimate()
//    }
//   
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return GlobalVariables.SutraNames[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return GlobalVariables.SutraNames.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        //GlobalVariables.index = row
//    }
//    
//    
//    @IBAction func ReturnFromPopUp(_ sender: UITapGestureRecognizer) {
//        NotificationCenter.default.post(name: Notification.Name("pickerused"), object: self)
//        self.removeAnimate()
//    }
//    
//    func showAnimate() {
//        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//        self.view.alpha = 0.0;
//        UIView.animate(withDuration: 0.25, animations: {
//            self.view.alpha = 1.0
//            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        });
//    }
//    
//    func removeAnimate() {
//        UIView.animate(withDuration: 0.25, animations: {
//            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            self.view.alpha = 0.0;
//        }, completion:{(finished : Bool)  in
//            if (finished)
//            {
//                self.view.removeFromSuperview()
//            }
//        });
//    }   
//    
//}
