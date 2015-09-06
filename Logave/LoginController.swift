//
//  LoginController.swift
//  Logave
//
//  Created by Alex on 05.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation
import UIKit

class LoginController:UITableViewController {
    
    var myUserName:UITextField? = nil
    var myPassWord:UITextField? = nil
    
    var data: NSMutableData = NSMutableData()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func GoUser(sender: AnyObject) {
        var passwrd:String? = self.myPassWord?.text
        var usrnm:String? = self.myUserName?.text
        
        let alertController = UIAlertController(title: "New user", message: "User:" + usrnm!+"Password:"+passwrd!.md5(), preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController,animated:true,completion:nil)
        
        myUserName?.resignFirstResponder()
        myPassWord?.resignFirstResponder()
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        NSLog("%d", indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier("Login", forIndexPath: indexPath) as! CustomCell
        if indexPath.row == 0 {
            self.myUserName = cell.userCell
            self.myUserName?.placeholder = "Email"
        } else {
            self.myPassWord = cell.userCell
            self.myPassWord?.placeholder = "Password"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
}