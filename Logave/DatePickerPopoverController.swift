//
//  DatePickerPopoverController.swift
//  Logave
//
//  Created by Andrew Johnsson on 22.11.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class DatePickerPopoverController: UITableViewController{
    
    var sevendays = [NSDate]()
    
    let temp = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var selectedDate:NSDate?
    
    @IBAction func setDate(sender: AnyObject) {
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("day") as UITableViewCell!
        
        cell?.textLabel?.text = temp[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
}
