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
    fileprivate var homeButton: FlatButton!
    fileprivate var foldingButton: FlatButton!
    fileprivate var meditationButton: FlatButton!
    fileprivate var logoutButton: FlatButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = main
        prepareHomeButton()
        prepareMeditationButton()
        prepareFurtherInfoButton()
        prepareAcknowledgmentsButton()
    }
}

extension LeftMenu {
    
    fileprivate func prepareHomeButton() {
        homeButton = FlatButton(title: "Home", titleColor: .white)
        homeButton.pulseColor = .white
        homeButton.addTarget(self, action: #selector(homeAction), for: .touchUpInside)
        view.layout(homeButton).horizontally().centerVertically(offset: -120).height(60)
    }
    
    fileprivate func prepareMeditationButton() {
        meditationButton = FlatButton(title: "Meditation", titleColor: .white)
        meditationButton.pulseColor = .white
        meditationButton.addTarget(self, action: #selector(meditationAction), for: .touchUpInside)
        
        view.layout(meditationButton).horizontally().centerVertically(offset: -60).height(60)
    }
    
    func prepareFurtherInfoButton() {
        logoutButton = FlatButton(title: "Further Info", titleColor: .white)
        logoutButton.pulseColor = .white
        logoutButton.addTarget(self, action: #selector(furtherInfoAction), for: .touchUpInside)
        view.layout(logoutButton).horizontally().centerVertically(offset: 0).height(60)
    }
    
    func prepareAcknowledgmentsButton() {
        logoutButton = FlatButton(title: "Acknowledgments", titleColor: .white)
        logoutButton.pulseColor = .white
        logoutButton.addTarget(self, action: #selector(acknowledgmentsAction), for: .touchUpInside)
        view.layout(logoutButton).horizontally().centerVertically(offset: 60).height(60)
    }
    
    func furtherInfoAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MoreInfo(), completion: closeNavigationDrawer)
    }
    
    func meditationAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: SoundsViewController(), completion: closeNavigationDrawer)
    }
    
    func homeAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: HomeVC(), completion: closeNavigationDrawer)
    }
    
    func acknowledgmentsAction() {
//        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MainVC(), completion: closeNavigationDrawer)
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}
