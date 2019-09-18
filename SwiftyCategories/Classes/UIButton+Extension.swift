//
//  UIButton+Extension.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//

import Foundation
import UIKit

private var customStateAssociationKey: UInt8 = 0

public extension UIButton {
    var customState: Int! {
        get {
            return objc_getAssociatedObject(self, &customStateAssociationKey) as? Int
        }
        set(newValue) {
            objc_setAssociatedObject(self, &customStateAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}


public extension UIButton {
}
