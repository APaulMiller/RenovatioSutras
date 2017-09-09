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
        prepareMenuButton()
        prepareStatusBar()
        prepareToolbar()
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
        statusBar.backgroundColor = main
    }
    
    func prepareToolbar() {
        toolbar.leftViews = [menuButton]
        toolbar.backgroundColor = main
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
    func showRightView() {
        navigationDrawerController?.toggleRightView()
    }
    
}
