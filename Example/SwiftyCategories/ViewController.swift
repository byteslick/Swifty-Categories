//
//  ViewController.swift
//  SwiftyCategories
//
//  Created by byteslick on 09/17/2019.
//  Copyright (c) 2019 byteslick. All rights reserved.
//

import UIKit
import SwiftyCategories

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            UIAlertController.showError("Hello")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(_ sender: Any) {
        let actionCompletionHandler:ActionCompletionBlock = { action in
            Print("OK Button Clicked.")
        }
        let title = "OK"
        
        let okAction:[Any] = [title, actionCompletionHandler]
        
        let alertCompletionHandler:AlertCompletionBlock = { alert in
            Print(alert.title)
        }
        
        UIAlertController.show(title:"Custom Title", message:"Your custom message.", actions: [okAction], completionHandler:alertCompletionHandler)
    }
}

