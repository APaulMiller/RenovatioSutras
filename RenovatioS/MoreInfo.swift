//
//  MoreInfo.swift
//  RenovatioS
//
//  Created by Paul Miller on 6/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import WebKit
import Material

class MoreInfo: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var TPOYPwebpage: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layout(TPOYPwebpage).left().right().top().bottom()
        let url = URL(string: "http://thepowerofyourperceptions.com")
        TPOYPwebpage.load(URLRequest(url: url!))
    }
}
