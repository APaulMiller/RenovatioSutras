//
//  UIColor.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func colorWithRGB(_ rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func colorRGB(_ redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
    
    static func solidColor(_ redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat) -> UIColor {
        return colorRGB(redValue, greenValue: greenValue, blueValue: blueValue, alpha: 1)
    }
    
    static func halfColor(_ redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat) -> UIColor {
        return colorRGB(redValue, greenValue: greenValue, blueValue: blueValue, alpha: 0.5)
    }
    
    class func interpolate(_ from: UIColor, to: UIColor, progress: CGFloat) -> UIColor {
        var from_red: CGFloat = 0
        var from_green: CGFloat = 0
        var from_blue: CGFloat = 0
        var from_alpha: CGFloat = 0
        from.getRed(&from_red, green: &from_green, blue: &from_blue, alpha: &from_alpha)
        
        var to_red: CGFloat = 0
        var to_green: CGFloat = 0
        var to_blue: CGFloat = 0
        var to_alpha: CGFloat = 0
        to.getRed(&to_red, green: &to_green, blue: &to_blue, alpha: &to_alpha)
        
        let interpolate = { (from: CGFloat, to: CGFloat) -> CGFloat in
            from + (to - from) * progress
        }
        
        return UIColor(
            red: interpolate(from_red, to_red),
            green: interpolate(from_green, to_green),
            blue: interpolate(from_blue, to_blue),
            alpha: interpolate(from_alpha, to_alpha)
        )
    }
    
}
