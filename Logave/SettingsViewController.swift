//
//  SettingsViewController.swift
//  Logave
//
//  Created by Andrew Johnsson on 17.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class SettingsViewController:UITableViewController{
    @IBOutlet weak var touchIDCell: UITableViewCell!
    
    @IBAction func closeSettings(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        let switchDisclosure = UISwitch()
        touchIDCell.accessoryView = switchDisclosure
        if switchDisclosure.on == true{
            NSLog("Touch ID Enabled")
        }
        else{
            NSLog("Touch ID Disabled")
        }
    }
}