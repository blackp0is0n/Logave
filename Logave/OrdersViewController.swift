//
//  OrdersViewController.swift
//  Logave
//
//  Created by Andrew Johnsson on 15.09.15.
//  Copyright © 2015 Alex. All rights reserved.
//

import UIKit

class OrdersViewController:UITableViewController{
    
    @IBOutlet var table: UITableView!
    
    let orders = ["Apples","Trash Bins","Windows","Penguins"]
    let distantions = ["150m","350m","1km","800m"]
    var data: NSMutableData = NSMutableData()
    
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
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    func showAlert(title: String,message: String){
        let alertController = UIAlertController(title: title,message:message, preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController,animated:true,completion:nil)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error:NSError! ){
        //showAlert("Issue",message: "Check your internet connection")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString("2015-09-05")
        let tasks:[Task] = CoreDataController.getTasks(date!)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {//////Доделать!!!!!!!!
        let key:String = JsonParserHelper.getKey(data)
        let tasks:[Task] = JsonParserHelper.getTasks(data)
        CoreDataController.setKey(key)
        //CoreDataController.setTasks(tasks)
        if tasks.count > 0 {
            CoreDataController.setTasks(tasks)
            var datastring = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
        } else {
            showAlert("Error", message: "Re-Check Your Credentials")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
