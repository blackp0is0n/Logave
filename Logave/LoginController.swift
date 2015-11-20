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
    @IBOutlet weak var authUsername: UITextField!
    @IBOutlet weak var authPassword: UITextField!
    
    var data: NSMutableData = NSMutableData()
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func authUser(sender: AnyObject) {
        let username:String? = authUsername.text
        let password:String? = authPassword.text
        
        authUsername?.resignFirstResponder()
        authPassword?.resignFirstResponder()
        
        let urlPath: String = "http://api.logave.com/user/login?device=c21592b180d10e601f2080111fc657de&email="
        
        let pather:String = urlPath + String(format: "\(username!)&password=\(password!.md5())")
        
        print(pather)
        self.data = NSMutableData()
        let url: NSURL = NSURL(string: pather)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
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
        let user:User? = JsonParserHelper.getUserFromData(data)
        if user != nil{
            CoreDataController.setSafeUser(user!)
            authCompleted()
            //performSegueWithIdentifier("authCompleted", sender: self)
        } else {
            showAlert("Error", message: "Re-Check Your Credentials")
        }
        
    }
    
    func authCompleted(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("mapController")
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("settingsView")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let slideMenuController = SlideMenuController(mainViewController:mainViewController, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        appDelegate.window?.rootViewController = slideMenuController
        appDelegate.window?.makeKeyAndVisible()
    }
}