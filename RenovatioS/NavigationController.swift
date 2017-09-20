//
//  NavigationController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/20/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Material

class AppNavigationController: NavigationController {
    open override func prepare() {
        super.prepare()
        isMotionEnabled = true
        motionNavigationTransitionType = .autoReverse(presenting: .zoom)
        navigationBar.depthPreset = .none
        navigationBar.dividerColor = .clear
    }
}
