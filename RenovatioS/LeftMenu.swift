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
    fileprivate var foldingButton: FlatButton!
    fileprivate var meditationButton: FlatButton!
    fileprivate var logoutButton: FlatButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = main
        prepareSutraButton()
        prepareMeditationButton()
        prepareFurtherInfoButton()
        prepareAcknowledgmentsButton()
    }
    
}

extension LeftMenu {

    fileprivate func prepareSutraButton() {
        sutraButton = FlatButton(title: "Sutra", titleColor: .white)
        sutraButton.pulseColor = .white
        sutraButton.addTarget(self, action: #selector(sutraAction), for: .touchUpInside)
        view.layout(sutraButton).horizontally().centerVertically(offset: -120).height(60)
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
    
    func sutraAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: PhotoViewController(), completion: closeNavigationDrawer)
    }
    
    func acknowledgmentsAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: PhotoViewController(), completion: closeNavigationDrawer)
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}
