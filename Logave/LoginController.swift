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
        let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        if let serverData: AnyObject = decodedJson["data"] {
            if let data: AnyObject = serverData["data"] {
                if let sData:String  = data as? String{
                    showAlert(sData, message: "Type email and password again")
                    return
                }
                if let user: AnyObject? = data["user"]{
                    let key:String = user!["key"] as! String
                    print("------")
                    print(user)
                    print("------")
                    print(key)
                    print("------")
                    performSegueWithIdentifier("successfulAuthSegue", sender: nil)
                }
            }
        }
    }    
}