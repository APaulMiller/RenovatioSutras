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
    }

    // MARK: Prepare Methods
    func prepareView() {
        view.backgroundColor = .black
    }
    
    func getObjects() {
        allObjects = (dataBaseManager?.getAllObject())!
    }

    func prepareFrontView() {
        frontView = UIImageView(frame: view.frame)
        frontView.contentMode = .scaleAspectFill
        frontView.image = #imageLiteral(resourceName: "aFrontPage")
        view.layout(frontView).left().right().top().bottom()
    }
    
    func updateView(object: SutraObject){
        frontView.image = object.image
        titleLabel.text = object.title
        textView.attributedText = object.detailText?.HTMLTooAttributedString
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
        backView.layout(textView).top(80).width(view.width - 30).centerHorizontally().bottom(20)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func pickerpix () {
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
        if allObjects.count > 1 {
        index = (index < allObjects.count-1) ? index+1 : 0
        
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.updateView(object: self.allObjects[self.index])},
                          completion: nil)
        }
    }

    func RightSwipeAction() {
        if allObjects.count > 1 {
        index = (index > 0) ? index-1 : allObjects.count-1
        UIView.transition(with: self.frontView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.updateView(object: self.allObjects[self.index])},
                          completion: nil)
        }
    }
    
    func swipeDownAction() {
        if showingBack { return }
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PickerVC
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func swipeUPAction() {
        let sutra = SutraObject(title: "A Front Page", detailText: nil, imageURL: "", image: #imageLiteral(resourceName: "aFrontPage"), index: 0)
        dataBaseManager?.save(sutra: sutra)
        print("Saved: ", sutra.title, index)
    }
    
    func flipAction() {
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

