//
//  String.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/9/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//
import Foundation
import UIKit

extension String {
    var HTMLTooAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options:[NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
