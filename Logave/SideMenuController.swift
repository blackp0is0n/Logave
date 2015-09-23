//
//  SideMenuController.swift
//  Logave
//
//  Created by Andrew Johnsson on 17.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class SideMenuController:UITableViewController{
    
    var menuItems = ["Tasks", "Messages", "Settings"]
    var currentItem = "Tasks"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuTableViewController = segue.sourceViewController as! SideMenuController
        if let selectedRow = menuTableViewController.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
    }
    
    /*func addBlur(){
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        blurView.frame = CGRect(x: 0, y: 0, width: navigationController!.navigationBar.bounds.size.width, height: navigationController!.navigationBar.bounds.height)
        self.navigationController?.navigationBar.addSubview(blurView)
        self.navigationController?.navigationBar.sendSubviewToBack(blurView)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        let blurViewLeading = NSLayoutConstraint(item: blurView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        let blurViewTrailing = NSLayoutConstraint(item: blurView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
        let blurViewBottom = NSLayoutConstraint(item: blurView, attribute: .Bottom, relatedBy: .Equal, toItem: self.navigationController?.navigationBar, attribute: .Bottom, multiplier: 1, constant: 0)
        let blurViewTop = NSLayoutConstraint(item: blurView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
        
        self.view.addConstraint(blurViewLeading)
        self.view.addConstraint(blurViewTrailing)
        self.view.addConstraint(blurViewBottom)
        self.view.addConstraint(blurViewTop)
    }*/
    
    override func viewDidLoad() {
        //addBlur();
        self.navigationItem.hidesBackButton = true
    }
}
