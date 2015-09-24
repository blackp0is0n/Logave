//
//  OrdersViewController.swift
//  Logave
//
//  Created by Andrew Johnsson on 15.09.15.
//  Copyright © 2015 Alex. All rights reserved.
//

import UIKit

class OrdersViewController:UITableViewController, slideViewTransitionManagerDelegate{
    @IBOutlet var table: UITableView!
    
    let orders = ["Apples","Trash Bins","Windows","Penguins"]
    let distantions = ["150m","350m","1km","800m"]
    
    var slideTransitionManager = SlideTransitionManager()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenu" {
            let menuTableViewController = segue.destinationViewController as! SideMenuController
            menuTableViewController.transitioningDelegate = self.slideTransitionManager
        }
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let order = tableView.dequeueReusableCellWithIdentifier("orderCell") as UITableViewCell!
        
        order.textLabel?.text = orders[indexPath.row]
        order.detailTextLabel?.text = distantions[indexPath.row]
        
        return order
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: (NSIndexPath!)) {
        self.performSegueWithIdentifier("showOrderDetails", sender: self)
    }
    
    override func viewDidLoad() {
        if (UIDevice.currentDevice().model == "iPad") {
            performSegueWithIdentifier("showMenu", sender: nil)
        }
        super.viewDidLoad()
    }
}
