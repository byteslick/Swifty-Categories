//
//  UIStoryboard+Extension.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//

import UIKit

public extension UIStoryboard{
    
    static func loadController(storyboard:UIStoryboard? = nil, storyboardName:String? = nil,  vcStoryboardId:String? = nil, bundle:Bundle? = nil){
        DispatchQueue.main.async {
            let storyboard = storyboard ?? UIStoryboard(name: storyboardName ?? "Main", bundle: bundle ?? Bundle.main)
            if let window = UIApplication.shared.delegate?.window{
                var vc:UIViewController?
                if let vcID = vcStoryboardId{
                    vc = storyboard.instantiateViewController(withIdentifier: vcID)
                }else{
                    vc = storyboard.instantiateInitialViewController()
                }
                window?.rootViewController = vc
            }
        }
    }
    
}
