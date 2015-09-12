//
//  LoginController.swift
//  Logave
//
//  Created by Alex on 05.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation
import UIKit

class LoginController:UITableViewController {
    
    var myUserName:UITextField? = nil
    var myPassWord:UITextField? = nil
    
    var data: NSMutableData = NSMutableData()
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func GoUser(sender: AnyObject) {
        var passwrd:String? = self.myPassWord?.text
        var usrnm:String? = self.myUserName?.text
        
        
        myUserName?.resignFirstResponder()
        myPassWord?.resignFirstResponder()
        
        let urlPath: String = "http://api.logave.com/user/login?device=c21592b180d10e601f2080111fc657de&email="
        
        let pather:String = urlPath + String(format: "\(usrnm!)&password=\(passwrd!.md5())")

        println(pather)
        self.data = NSMutableData()
        var url: NSURL = NSURL(string: pather)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()
        
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
        showAlert("Issue",message: "Check your internet connection")
    }
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var datastring = NSString(data:self.data, encoding:NSUTF8StringEncoding) as! String
        
        var jsonError: NSError?
        let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! Dictionary<String, AnyObject>
        if jsonError == nil {
            if let serverData: AnyObject = decodedJson["data"] {
                if let data: AnyObject = serverData["data"] {
                    if let sData:String  = data as? String{
                        showAlert(sData, message: "Type email and password again")
                        return
                    }
                    if let user: AnyObject? = data["user"]{
                        var key:String = user!["key"] as! String
                        println("------")
                        println(user)
                        println("------")
                        println(key)
                        println("------")
                        showAlert("OOps", message: key)
                        
                        
                        /*var storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
                        
                        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                        
                        leftViewController.mainViewController = nvc
                        
                        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                        slideMenuController.closeLeft()
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        var myWindow = appDelegate.window
                        myWindow?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                        myWindow?.rootViewController = slideMenuController
                        myWindow?.makeKeyAndVisible()*/
                    }
                
                }
            }
        }
        
        //println(datastring)
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        NSLog("%d", indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier("login.Username", forIndexPath: indexPath) as! CustomCell
        if indexPath.row == 0 {
            self.myUserName = cell.userCell
            self.myUserName?.placeholder = "Email"
            self.myUserName?.text = "cr@vork.com"
        } else {
            self.myPassWord = cell.userCell
            self.myPassWord?.secureTextEntry = true
            self.myPassWord?.placeholder = "Password"
            self.myPassWord?.text = "12345"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
}