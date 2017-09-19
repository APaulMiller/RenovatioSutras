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
    var allObjects: [SutraObject] = [SutraObject]()
    var index = 0
    private let dataBaseManager = DatabaseManager.shared
    private var showingBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getObjects()
        prepareFrontView()
        prepareBackView()
        prepareSwipeLeft()
        prepareSwipeRight()
        prepareSwipeDown()
//        prepareSwipeUp()
        prepareTap()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pickerpix), name: Notification.Name("pickerused"), object: nil)
    }

    // MARK: Prepare Methods
    
    func getObjects() {
        guard let sutraRef = dataBaseManager?.getObjectRef(path: "pics") else {return}
        sutraRef.observe(.childAdded, with: { (snapshot) -> Void in
            let object = SutraObject(snapshot: snapshot)!
            self.allObjects.append(object)
        })
    }

    func prepareFrontView() {
        frontView = UIImageView(frame: view.frame)
        frontView.contentMode = .scaleAspectFill
        frontView.image = UIImage(named: "FrontPage")
        view.layout(frontView).left().right().top().bottom()
    }
    
    func updateView(object: SutraObject){
        frontView.image = UIImage(named: object.title)
        titleLabel.text = object.title
        textView.attributedText = object.detailText?.HTMLTooAttributedString
    }
    
    func prepareBackView() {
        backView = UIView(frame: view.frame)
        titleLabel.textAlignment = .center
        titleLabel.font = RobotoFont.regular(with: 22)
        textView.numberOfLines = 0
        backView.layout(titleLabel).top(22).height(40).centerHorizontally()
        backView.layout(textView).top(80).left(10).right(10)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func pickerpix () {
        // This is used on returning from the Picker PopOver to select the new Sutra Image
//        let sutraName: String = GlobalVariables.SutraNames[index]
//        frontView.image = UIImage(named: sutraName)
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
    
//    func prepareSwipeUp() {
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUPAction))
//        swipeUp.direction = .up
//        swipeUp.delegate = self
//        view.addGestureRecognizer(swipeUp)
//    }
    
    func prepareTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipAction))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Actions
    
    func leftSwipeAction() {
        index = (index < allObjects.count-1) ? index+1 : 0
        
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.updateView(object: self.allObjects[self.index])},
                          completion: nil)
    }
    
    func RightSwipeAction() {
        index = (index > 0) ? index-1 : allObjects.count-1
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.updateView(object: self.allObjects[self.index])},
                          completion: nil)
    }
    
    func swipeDownAction() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PickerVC
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
//    func swipeUPAction() {
//        let sutraName: String = GlobalVariables.SutraNames[index]
//        let sutra = SutraObject(title: GlobalVariables.SutraNames[index], detailText: RSarray[index], imageURL: nil, image: UIImage(named: sutraName))
//        dataBaseManager?.save(sutra: sutra)
//        print("Saved: ", sutra.title, index)
//    }
    
    func flipAction() {
        let toView = showingBack ? frontView : backView
        let fromView = showingBack ? backView : frontView
        let trasition = showingBack ? UIViewAnimationOptions.transitionFlipFromRight : UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: trasition, completion: nil)
        view.layout(toView).left().right().top().bottom()
        showingBack = !showingBack
    }
}



