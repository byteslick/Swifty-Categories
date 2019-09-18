//
//  Utils.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//

import UIKit

public typealias VoidBlock = (() -> Void)
public typealias AlertCompletionBlock = ((UIAlertController) -> Void)
public typealias ActionCompletionBlock = ((UIAlertAction) -> Void)

var alertQueue:[Any] = []

public extension UIAlertController {
    
    
    static func showCancel(_ title:String? = nil, _ message:String? = nil, _ cancelButtonTitle:String? = nil, _ completionHandler: Any? = nil){
        var arr:[Any] = []
        arr.append(cancelButtonTitle ?? "Cancel")
        arr.append(UIAlertAction.Style.cancel)
        UIAlertController.show(title:title, message:message, actions: [arr], completionHandler: completionHandler)
    }
    
    
    static func showSuccess(_ title:String?, _ message:String?, _ successButtonTitle:String?, _ completionHandler: Any?){
        var arr:[Any] = []
        arr.append(successButtonTitle ?? "OK")
        arr.append(UIAlertAction.Style.default)
        UIAlertController.show(title:title, message:message, actions: [arr], completionHandler: completionHandler)
    }
    
    
    static func showError(_ title:String? = nil, _ message:String? = nil, _ errorButtonTitle:String? = nil, _ completionHandler: Any? = nil){
        var arr:[Any] = []
        arr.append(errorButtonTitle ?? "OK")
        arr.append(UIAlertAction.Style.destructive)
        UIAlertController.show(title:title, message:message, actions: [arr], completionHandler: completionHandler)
    }
    
    /**
     actions:[Any] : [Any] must be in order:
     1. Action Button Title
     2. Action Button Style
     3. Completion Handler '(() -> Void)?' typealias 'Block'
     */
    
    
    static func show(title:String? = nil, message:String? = nil, defaultTextInputs:[[String:String]]? = nil, actions:[Any] , completionHandler: Any? = nil){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        //Print(actions)
        if let textInputs = defaultTextInputs{
            //Print(textInputs)
            for inputParams in textInputs{
                alertController.addTextField { (textField) in
                    if inputParams["place_holder"] != nil{
                        textField.placeholder = inputParams["place_holder"]
                    }
                    if inputParams["default_text"] != nil{
                        textField.text = inputParams["default_text"]
                    }
                    if inputParams["is_secure"] != nil{
                        textField.isSecureTextEntry = inputParams["is_secure"]?.lowercased() == "true"
                    }
                }
            }
        }
        for actionItem in actions{
            //Print(actionItem)
            if let items = actionItem as? [Any]{
                var actionTitle:String?
                var actionStyle:UIAlertAction.Style?
                var actionCompletionHandler:Any?
                for object in items{
                    if object is String{
                        actionTitle = object as? String
                    }else if object is UIAlertAction.Style{
                        actionStyle = object as? UIAlertAction.Style
                    }else if object is VoidBlock{
                        actionCompletionHandler = object as? VoidBlock
                    }else if object is ActionCompletionBlock{
                        actionCompletionHandler = object as? ActionCompletionBlock
                    }else if object is AlertCompletionBlock{
                        actionCompletionHandler = object as? AlertCompletionBlock
                    }
                }
                let action = UIAlertAction(title: actionTitle, style: actionStyle ?? .default) { (action) in
                    if let actionBlock = actionCompletionHandler as? VoidBlock{
                        actionBlock()
                    }else if let actionBlock = actionCompletionHandler as? ActionCompletionBlock{
                        actionBlock(action)
                    }else if let actionBlock = actionCompletionHandler as? AlertCompletionBlock{
                        actionBlock(alertController)
                    }
                }
                alertController.addAction(action)
            }
        }
        alertQueue.append(completionHandler != nil ? [alertController, completionHandler!] : [alertController])
        UIAlertController.showAlert()
    }
    
    private static func showAlert(){
        
        if alertQueue.count > 0{
            if let presentingViewController = visibleViewController() as? UIViewController{
                if presentingViewController is UIAlertController{
                    let when = DispatchTime.now() + DispatchTimeInterval.seconds(1)
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        UIAlertController.showAlert()
                    }
                }else{
                    guard let alertControllerItem = alertQueue.first as? [Any] else{
                        //Print("Alert Quest Has No Items")
                        return
                    }
                    var alertController:UIAlertController!
                    var alertCompletionHandler:Any?
                    for object in alertControllerItem{
                        if object is UIAlertController{
                            alertController = object as? UIAlertController
                        }else if object is VoidBlock{
                            alertCompletionHandler = object as? VoidBlock
                        }else if object is AlertCompletionBlock{
                            alertCompletionHandler = object as? AlertCompletionBlock
                        }
                    }
                    presentingViewController.present(alertController, animated: true) {
                        if let alertBlock = alertCompletionHandler as? VoidBlock{
                            alertBlock()
                        }else if let alertBlock = alertCompletionHandler as? AlertCompletionBlock{
                            alertBlock(alertController)
                        }
                    }
                    alertQueue.remove(at: 0)
                }
            }
        }
    }
    
}

