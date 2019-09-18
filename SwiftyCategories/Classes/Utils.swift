//
//  Utils.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//
import UIKit
import Foundation

public func Print(_ items: Any...){
    #if DEBUG
        debugPrint(items)
    #endif
}

public func visibleViewController(_ inController:Any? = nil) -> Any?{
    if let rootController = inController == nil ? UIApplication.shared.windows.last?.rootViewController : inController{
        if let controller = rootController as? UINavigationController,
            controller.viewControllers.count > 0{
            if controller.visibleViewController != controller.topViewController{
                //Print(controller.visibleViewController!)
                return visibleViewController(controller.visibleViewController)
            }else{
                //Print(controller)
                return controller.visibleViewController
            }
        }else if let controller = (rootController as? UIViewController){
            if let presentedController = controller.presentedViewController{
                //Print(presentedController)
                return visibleViewController(presentedController)
            }else{
                //Print(controller)
                return controller
            }
        }
    }
    return nil
}

