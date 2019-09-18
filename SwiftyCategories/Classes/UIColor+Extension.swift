//
//  UIColor+Extension.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//

import Foundation
import UIKit

public extension UIColor{
    static func colorWithString(_ string:String? = nil) -> UIColor{
        guard let colorString = string else{
            return UIColor.clear
        }
        let colors = colorString.components(separatedBy: ",")
        if colors.count > 2{
            return UIColor.init(red: CGFloat((colors[0] as NSString).floatValue/255.0), green: CGFloat((colors[1] as NSString).floatValue/255.0), blue: CGFloat((colors[2] as NSString).floatValue/255.0), alpha: 1.0)
        }else{
            return UIColor.clear
        }
    }
}
