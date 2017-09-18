//
//  UIImageView.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/18/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit

extension UIImageView {
    func setRemoteImage(imageURL: URL?) {
        if let url = imageURL {
            self.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(qos: .userInitiated), imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true, completion: nil)
        }
    }
}
