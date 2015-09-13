//
//  CoreDataController.swift
//  Logave
//
//  Created by Alex on 12.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataController{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func testFunc(){
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("\(error1.description)\n")
            result = nil
        }
        for resultItem in result! {
            let name:String = resultItem.valueForKey("name") as! String
            //var sName:String = resultItem.valueForKey("sName") as! String
            //var key:String = resultItem.valueForKey("key") as! String
            //var keyDate:String = resultItem.valueForKey("keyDate") as! String
            //var email:String = resultItem.valueForKey("email") as! String
            NSLog("Fetched item: \(name) ")
        }
    }
    func setUser(user:User?){
        
    }
    
    func getUser() -> User?{
        
        return nil
    }
    
    func getMessages() -> [Message?]{
        return []
    }
    
    func getTasks() -> [Task?]{
        return []
    }
}