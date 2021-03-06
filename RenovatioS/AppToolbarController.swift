//
//  AppToolbarController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//  This is the toobar on top of the app Which houses the Menu Button that controls the navigation throught the app. This is where you style that Toobar.

import UIKit
import Material

class AppToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    
    override func prepare() {
        super.prepare()
        displayStyle = .full
        prepareMenuButton()
        prepareStatusBar()
        prepareToolbar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension AppToolbarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.menu!.withRenderingMode(.alwaysTemplate))
        menuButton.tintColor = .white
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareStatusBar() {
        // Access the statusBar.
        statusBar.backgroundColor = UIColor.clear
    }
    
    func prepareToolbar() {
        toolbar.leftViews = [menuButton]    
        toolbar.backgroundColor = UIColor.clear
        toolbar.titleLabel.textColor = .white
        toolbar.detailLabel.textColor = .white
    }
}

extension AppToolbarController {
    @objc fileprivate func handleMenuButton() {
        navigationDrawerController?.setLeftViewWidth(width: 180, isHidden: true, animated: false)
        navigationDrawerController?.toggleLeftView()
    }
    
    @objc fileprivate func set(title: String) {
        toolbar.title = title
    }
    
}
