//
//  LeftMenu.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import Foundation
import Material

class LeftMenu: UIViewController {
    fileprivate var sutraButton: FlatButton!
    fileprivate var meditationButton: FlatButton!
    fileprivate var tpoypBlog: FlatButton!
    fileprivate var furtherInfo: FlatButton!
    fileprivate var acknowledgments: FlatButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.base.withAlphaComponent(0.9)
        prepareSutraButton()
        prepareMeditationButton()        
//To add a new menu option Step 1 of 4
        prepareTPOYPBlog()
        
        prepareFurtherInfoButton()
        prepareAcknowledgmentsButton()
    }
}



extension LeftMenu {

//Sutra Menu option
    func sutraAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: HomeVC(), completion: closeNavigationDrawer)
    }
    fileprivate func prepareSutraButton() {
        sutraButton = FlatButton(title: "Sutra", titleColor: .white)
        sutraButton.pulseColor = .white
        sutraButton.addTarget(self, action: #selector(sutraAction), for: .touchUpInside)
        view.layout(sutraButton).left(15).top(40)
    }
 
//Meditation Menu option
    func meditationAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: SoundsViewController(), completion: closeNavigationDrawer)
    }
    fileprivate func prepareMeditationButton() {
        meditationButton = FlatButton(title: "Meditation", titleColor: .white)
        meditationButton.pulseColor = .white
        meditationButton.addTarget(self, action: #selector(meditationAction), for: .touchUpInside)
        
        view.layout(meditationButton).left(15).top(80)
    }
    
//Blog menu option
//Create a this function Step 2 of 4
    func tpoypBlogAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: TPOYPBlog(), completion: closeNavigationDrawer)
    }
    
//Create this function below Step 3 of 4 (remember to shift the text down by 40 e.g. "top(120)"
//Step 4 of 4 is to create a Swift file whose name matches this part in the above function "transition(to: TPOYPBlog(), completion: closeNavigationDrawer)"

    func prepareTPOYPBlog() {
        tpoypBlog = FlatButton(title: "TPOYP Blog", titleColor: .white)
        tpoypBlog.pulseColor = .white
        tpoypBlog.addTarget(self, action: #selector(tpoypBlogAction), for: .touchUpInside)
        view.layout(tpoypBlog).left(15).top(120)
    }

//Further Info menu button
    func furtherInfoAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MoreInfo(), completion: closeNavigationDrawer)
    }
    
    func prepareFurtherInfoButton() {
        furtherInfo = FlatButton(title: "Further Info", titleColor: .white)
        furtherInfo.pulseColor = .white
        furtherInfo.addTarget(self, action: #selector(furtherInfoAction), for: .touchUpInside)
        view.layout(furtherInfo).left(15).top(160)
    }
    
 //Acknowledgements Menu option
    func acknowledgmentsAction() {
        //        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MainVC(), completion: closeNavigationDrawer)
    }
    func prepareAcknowledgmentsButton() {
        acknowledgments = FlatButton(title: "Acknowledgments", titleColor: .white)
        acknowledgments.pulseColor = .white
        acknowledgments.addTarget(self, action: #selector(acknowledgmentsAction), for: .touchUpInside)
        view.layout(acknowledgments).left(15).top(200)
    }
    
//Close the navigation Bar
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}
