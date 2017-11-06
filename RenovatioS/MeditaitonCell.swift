//
//  MeditaitonCell.swift
//  RenovatioS
//
//  Created by Dan Leonard on 11/5/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Material

class MeditaitonCell: UITableViewCell {
    let artworkImage = UIImageView()
    let stack = UIStackView()
    let label = UILabel()
    let button = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        selectionStyle = .none
        prepareImageView()
        prepareStack()
        prepareLabel()
        prepareButton()
    }
    
    private func prepareStack() {
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.distribution = .fill
        layout(stack).top(20).left(bounds.width/3 + 25).right(10).bottom(20)
    }
    
    private func prepareImageView() {
        layout(artworkImage).top(30).left(15).bottom(10).width(superview?.bounds.width ?? 300/3)
    }
    
    private func prepareLabel() {
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        stack.addArrangedSubview(label)
    }
    
    private func prepareButton() {
        button.text = "Play"
        button.textAlignment = .center
        button.font = RobotoFont.regular(with: 18)
        button.textColor = Color.blue.lighten1
        stack.addArrangedSubview(button)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        button.text = selected ? "Pause" : "Play"
    }
    
}
