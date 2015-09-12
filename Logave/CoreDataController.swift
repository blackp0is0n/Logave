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
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        var error: NSError? = nil
        
        var result = appDelegate.managedObjectContext!.executeFetchRequest(fReq, error:&error)
        for resultItem in result! {
            var name:String = resultItem.valueForKey("name") as! String
            var sName:String = resultItem.valueForKey("sName") as! String
            var key:String = resultItem.valueForKey("key") as! String
            var keyDate:String = resultItem.valueForKey("keyDate") as! String
            var email:String = resultItem.valueForKey("email") as! String
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