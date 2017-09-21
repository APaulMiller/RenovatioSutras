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
    fileprivate var furtherInfo: FlatButton!
    fileprivate var acknowledgments: FlatButton!
    
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
        view.layout(sutraButton).left(15).top(40)
    }
    
    fileprivate func prepareMeditationButton() {
        meditationButton = FlatButton(title: "Meditation", titleColor: .white)
        meditationButton.pulseColor = .white
        meditationButton.addTarget(self, action: #selector(meditationAction), for: .touchUpInside)
        
        view.layout(meditationButton).left(15).top(80)
    }
    
    func prepareFurtherInfoButton() {
        furtherInfo = FlatButton(title: "Further Info", titleColor: .white)
        furtherInfo.pulseColor = .white
        furtherInfo.addTarget(self, action: #selector(furtherInfoAction), for: .touchUpInside)
        view.layout(furtherInfo).left(15).top(120)
    }
    
    func prepareAcknowledgmentsButton() {
        acknowledgments = FlatButton(title: "Acknowledgments", titleColor: .white)
        acknowledgments.pulseColor = .white
        acknowledgments.addTarget(self, action: #selector(acknowledgmentsAction), for: .touchUpInside)
        view.layout(acknowledgments).left(15).top(160)
    }
    
    func furtherInfoAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MoreInfo(), completion: closeNavigationDrawer)
    }
    
    func meditationAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: SoundsViewController(), completion: closeNavigationDrawer)
    }
    
    func sutraAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: HomeVC(), completion: closeNavigationDrawer)
    }
    
    func acknowledgmentsAction() {
//        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MainVC(), completion: closeNavigationDrawer)
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}
