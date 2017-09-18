//
//  SutraObject.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/9/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Firebase

struct SutraObject {
    let title: String
    let detailText: String?
    let imageURL: String?
    var image: UIImage?
    private let storage = DatabaseManager.shared
    
    init(title: String, detailText: String? = nil, imageURL: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.detailText = detailText
        self.image = image
        self.imageURL = imageURL
    }
    
    init?(snapshot: DataSnapshot) {
        guard let json = snapshot.value as? [String: Any] else { return nil }
        self.title = json["title"] as! String
        self.detailText = json["detailText"] as? String
        self.imageURL = json["imageURL"] as? String
        self.image = nil
    }
}
