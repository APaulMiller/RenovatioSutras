//
//  Blog.swift
//  RenovatioS
//
//  Created by Paul Miller on 9/27/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import WebKit
import Material

class TPOYPBlog: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var Blogwebpage: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layout(Blogwebpage).left().right().top().bottom()
        let url = URL(string: "https://paultpoypblog.tumblr.com/")
        Blogwebpage.load(URLRequest(url: url!))
    }
}

