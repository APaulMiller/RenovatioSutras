//
//  SutraObject.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/9/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

struct SutraObject {
    let title: String
    let detailText: String?
    let image: UIImage?
    
    init(title: String, detailText: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.detailText = detailText
        self.image = image
    }
}
