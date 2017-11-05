//
//  TumblerViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/22/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import WebKit
import Material

class tumblerViewController: UIViewController {
    
    var webView: WKWebView = WKWebView()
    private let address = "https://paultpoypblog.tumblr.com/"
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layout(webView).left().right().top().bottom()
        webView.load(URLRequest(url: URL(string: address)!))
    }
}
