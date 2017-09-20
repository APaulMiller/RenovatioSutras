//
//  AppToolbarController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Material

class AppToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    
    override func prepare() {
        super.prepare()
        isMotionEnabled = true
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
        menuButton = IconButton(image: Icon.cm.menu?.withRenderingMode(.alwaysTemplate))
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
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
    
    @objc
    fileprivate func set(title: String) {
        toolbar.title = title
    }
    
}
