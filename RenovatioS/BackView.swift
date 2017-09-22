//
//  BackView.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/21/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import Material
import UIKit

class  BackView: UIView, UIGestureRecognizerDelegate {
    var titleLabel: UILabel = UILabel()
    var textView: UILabel = UILabel()
    var scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scrollView)
        layout(scrollView).edges()
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView() {
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = RobotoFont.regular(with: 22)
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        scrollView.layout(titleLabel).top(26).height(40).centerHorizontally()
        scrollView.layout(textView).top(80).width(self.width - 30).centerHorizontally().bottom(20)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.delegate = self
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    func dismissView() {
        UIView.setAnimationTransition(.flipFromRight, for: self, cache: true)
    }
    
    func updateTextFeilds(title: String, attributedText: String) {
        titleLabel.text = title
        textView.attributedText = attributedText.HTMLTooAttributedString
    }
}
