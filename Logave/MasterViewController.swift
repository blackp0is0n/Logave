//
//  MasterViewController.swift
//  Logave
//
//  Created by Andrew Johnsson on 13.09.15.
//  Copyright © 2015 Alex. All rights reserved.
//

import UIKit

class MasterViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.masterViewController = self
        
        NSLog("appDelegate patched")
    }
    
    func change(){
        performSegueWithIdentifier("showTasks", sender: self)
    }
    
}
