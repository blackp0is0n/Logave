//
//  SideMenuController.swift
//  Logave
//
//  Created by Andrew Johnsson on 19.11.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class SideMenuController: UITableViewController{
    let menuItems = ["Tasks","Messages","Settings"]
    
    var tasksController:UINavigationController? = nil
    var messagesController:UINavigationController? = nil
    var slidecontroller:SlideMenuController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.textLabel!.text = menuItems[indexPath.row]
        //self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            print("0 is selected")
            self.slidecontroller?.changeMainViewController(tasksController!, close: true)
        case 1:
            print("1 selected")
            self.slidecontroller?.changeMainViewController(messagesController!, close: true)
        default:
            print("Default")
        }
    }
    
}