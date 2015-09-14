//
//  SideViewController.swift
//  Logave
//
//  Created by Andrew Johnsson on 13.09.15.
//  Copyright © 2015 Alex. All rights reserved.
//

import UIKit

class SideViewController: UITableViewController{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBAction func touch(sender: AnyObject) {
        let masterTest = appDelegate.masterViewController
        masterTest?.change()
    }
    @IBOutlet weak var touchTasks: UIButton!
    
}
