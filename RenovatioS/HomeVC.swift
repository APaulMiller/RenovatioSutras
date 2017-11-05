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
    var backView = UIScrollView()
    var titleLabel: UILabel = UILabel()
    var textView: UILabel = UILabel()
    var allObjects: [SutraObject] = [SutraObject]()
    var index: Int = 0
    private let dataBaseManager = DatabaseManager.shared
    private var showingBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        getObjects()
        prepareFrontView()
        prepareBackView()
        prepareSwipeLeft()
        prepareSwipeRight()
        prepareSwipeDown()
//        prepareSwipeUp()
        prepareTap()
        NotificationCenter.default.addObserver(self, selector: #selector(getObjects), name: Notification.Name("newImages"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pickerpix), name: Notification.Name("pickerused"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(reloadCard), name: Notification.Name("newData"), object: nil)
    }

    // MARK: Prepare Methods
    func prepareView() {
        view.backgroundColor = .black
    }
    
    @objc func getObjects() {
        allObjects = (dataBaseManager?.getAllObject())!.sorted{$0.title < $1.title}
    }

    func prepareFrontView() {
        frontView = UIImageView(frame: view.frame)
        frontView.contentMode = .scaleAspectFill
        frontView.image = UIImage(named: "FrontPage")
        view.layout(frontView).left().right().top().bottom()
    }
    
    func updateView(object: SutraObject){
        frontView.image = object.image
        titleLabel.text = object.title
        textView.attributedText = object.detailText?.HTMLTooAttributedString
    }

    @objc func reloadCard() {
        getObjects()
        updateView(object: allObjects[index])
    }
    
    func prepareBackView() {
        backView = UIScrollView(frame: view.frame)
        backView.alwaysBounceVertical = true
        backView.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = RobotoFont.regular(with: 22)
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        backView.layout(titleLabel).top(26).height(40).centerHorizontally()
        backView.layout(textView).top(80).width(view.bounds.width - 30).centerHorizontally().bottom(20)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func pickerpix () {
        self.index = GlobalVariables.index
        updateView(object: allObjects[index])
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
    
    @objc func leftSwipeAction() {
        index = (index < allObjects.count-1) ? index+1 : 0
        
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.updateView(object: self.allObjects[self.index])},
                          completion: nil)
    }

    @objc func RightSwipeAction() {
        index = (index > 0) ? index-1 : allObjects.count-1
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.updateView(object: self.allObjects[self.index])},
                          completion: nil)
    }
    
    @objc func swipeDownAction() {
        if showingBack { return }
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PickerVC
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
//    func swipeUPAction() {
//        let sutraName: String = GlobalVariables.SutraNames[GlobalVariables.index]
//        let sutra = SutraObject(title: GlobalVariables.SutraNames[GlobalVariables.index], detailText: RSarray[GlobalVariables.index], imageURL: nil, image: UIImage(named: sutraName), index: GlobalVariables.index)
//        dataBaseManager?.save(sutra: sutra)
//        print("Saved: ", sutra.title, index)
//    }
    
    @objc func flipAction() {
        if allObjects[index].detailText == nil { return }
        let toView = showingBack ? frontView : backView
        let fromView = showingBack ? backView : frontView
        let trasition = showingBack ? UIViewAnimationOptions.transitionFlipFromRight : UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: trasition, completion: nil)
        view.layout(toView).left().right().top().bottom()
        toView.translatesAutoresizingMaskIntoConstraints = false
        showingBack = !showingBack
    }
}

