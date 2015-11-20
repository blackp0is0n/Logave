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
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    
    override func viewDidLoad() {
        let user = CoreDataController.getUser()
        let switchDisclosure = UISwitch()
        touchIDCell.accessoryView = switchDisclosure
        if switchDisclosure.on == true{
            print("Touch ID Enabled")
        }
        else{
            print("Touch ID Disabled")
        }
    }
}