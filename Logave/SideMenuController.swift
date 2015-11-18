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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.textLabel!.text = menuItems[indexPath.row]
        
        return cell
    }
    
}