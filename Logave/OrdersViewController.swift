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
    
    var data: NSMutableData = NSMutableData()
    var tasks:[Task] = [Task]()
    
    func showAlert(title: String,message: String){
        let alertController = UIAlertController(title: title,message:message, preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController,animated:true,completion:nil)
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error:NSError! ){
        //showAlert("Issue",message: "Check your internet connection")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString("2015-09-05")
        self.tasks = CoreDataController.getTasks(date!)
        self.tableView.reloadData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {//////Доделать!!!!!!!!
        let key:String = JsonParserHelper.getKey(data)
        self.tasks = JsonParserHelper.getTasks(data)
        CoreDataController.setKey(key)
        if tasks.count > 0 {
            CoreDataController.setTasks(self.tasks)
            print(self.tasks.count)
            _ = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
            self.tableView.reloadData()
        } else {
            showAlert("Error", message: "Re-Check Your Credentials")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let order = tableView.dequeueReusableCellWithIdentifier("orderCell") as UITableViewCell!
        
        order.textLabel?.text = self.tasks[indexPath.row].description
        order.detailTextLabel?.text = "3m"   //Add distantantion calculation
        
        return order
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath: String = "http://api.logave.com/task/gettask?device=c21592b180d10e601f2080111fc657de&key="
        
        let pather:String = urlPath + CoreDataController.getUser().key + "&date=2015-09-05"
        
        //print(pather)
        self.data = NSMutableData()
        let url: NSURL = NSURL(string: pather)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()
    }
}
