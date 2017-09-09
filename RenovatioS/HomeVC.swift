//
//  HomeVC.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import Foundation
import Material

class HomeVC: UIViewController, UIGestureRecognizerDelegate {
    var frontView = UIImageView()
    var backView = UIView()
    var titleLabel: UILabel = UILabel()
    var textView: UILabel = UILabel()
    private let dataBaseManager = DatabaseManager.shared
    private var showingBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
        self.edgesForExtendedLayout = .top
        prepareFrontView()
        prepareBackView()
        prepareSwipeLeft()
        prepareSwipeRight()
        prepareSwipeDown()
        prepareSwipeUp()
        prepareTap()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pickerpix), name: Notification.Name("pickerused"), object: nil)
    }

    // MARK: Prepare Methods
    
    func prepareFrontView() {
        frontView = UIImageView(frame: view.frame)
        frontView.contentMode = .scaleAspectFill
        let sutraName: String = GlobalVariables.SutraNames[GlobalVariables.index]
        frontView.image = UIImage(named: sutraName)
        view.layout(frontView).left().right().top().bottom()
    }
    
    func prepareBackView() {
        backView = UIView(frame: view.frame)
        backView.layout(titleLabel).top(20).height(40).left().right()
        backView.layout(textView).top(80).left().right()
    }
    
    func updateBackText() {
        titleLabel.text = GlobalVariables.SutraNames[GlobalVariables.index]
        textView.text = RSarray[GlobalVariables.index]
    }

    func pickerpix () {
        // This is used on returning from the Picker PopOver to select the new Sutra Image
        let sutraName: String = GlobalVariables.SutraNames[GlobalVariables.index]
        frontView.image = UIImage(named: sutraName)
    }
    
    func prepareSwipeLeft() {
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction))
        leftGesture.direction = .left
        leftGesture.delegate = self
        view.addGestureRecognizer(leftGesture)
    }
    
    func prepareSwipeRight() {
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(RightSwipeAction))
        rightGesture.direction = .right
        rightGesture.delegate = self
        view.addGestureRecognizer(rightGesture)
    }
    
    func prepareSwipeDown() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeDown.direction = .down
        swipeDown.delegate = self
        view.addGestureRecognizer(swipeDown)
    }
    
    func prepareSwipeUp() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUPAction))
        swipeUp.direction = .up
        swipeUp.delegate = self
        view.addGestureRecognizer(swipeUp)
    }
    
    func prepareTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipAction))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Actions
    
    func leftSwipeAction() {
        GlobalVariables.index = (GlobalVariables.index < GlobalVariables.SutraNames.count-1) ? GlobalVariables.index+1 : 0
        let newSutraName:String = GlobalVariables.SutraNames[GlobalVariables.index]
        guard let NewSutraPix = UIImage(named: newSutraName) else {
            assertionFailure("No Image Found")
            return
        }
        
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.frontView.image = NewSutraPix},
                          completion: nil)
    }
    
    func RightSwipeAction() {
        
        GlobalVariables.index = (GlobalVariables.index > 0) ? GlobalVariables.index-1 : GlobalVariables.SutraNames.count-1
        let newSutraName = GlobalVariables.SutraNames[GlobalVariables.index]
        guard let NewSutraPix = UIImage(named: newSutraName) else {
            assertionFailure("No Image Found")
            return
        }
        
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.frontView.image = NewSutraPix},
                          completion: nil)
    }
    
    func swipeDownAction() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PickerVC
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func swipeUPAction() {
        let sutraName: String = GlobalVariables.SutraNames[GlobalVariables.index]
        let sutra = SutraObject(title: GlobalVariables.SutraNames[GlobalVariables.index], detailText: RSarray[GlobalVariables.index], image: UIImage(named: sutraName))
        dataBaseManager?.save(sutra: sutra)
        print("Saved: ", sutra.title)
    }
    
    func flipAction() {
        updateBackText()
        let toView = showingBack ? frontView : backView
        let fromView = showingBack ? backView : frontView
        let trasition = showingBack ? UIViewAnimationOptions.transitionFlipFromRight : UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: trasition, completion: nil)
        view.layout(toView).left().right().top().bottom()
        showingBack = !showingBack
    }
}

