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

    }
    func setUser(user:User?){
        removeMessages()
        removeTasks()
        removeUser()
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
        
        newManagedObject.setValue(user?.name, forKey: "name")
        newManagedObject.setValue(user?.sName, forKey: "sName")
        newManagedObject.setValue(user?.keyDate, forKey: "keyDate")
        newManagedObject.setValue(user?.key, forKey: "key")
        newManagedObject.setValue(user?.name, forKey: "email")
        newManagedObject.setValue(user?.expDate, forKey: "expDate")
        appDelegate.saveContext()
    }
    
    func getUser() -> User?{
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("Core Data Error!\(error1.description)\n")
            result = nil
        }
        let user:User = User()
        for resultItem in result! {
            user.name = resultItem.valueForKey("name") as? String
            user.sName = resultItem.valueForKey("sName") as? String
            user.key = resultItem.valueForKey("key") as? String
            user.keyDate = resultItem.valueForKey("keyDate") as? String
            user.email = resultItem.valueForKey("email") as? String
            break
        }
        return user
    }
    
    func getMessages() -> [Message?]{
        return []
    }
    
    func getTasks() -> [Task?]{
        return []
    }
    
    func removeUser(){
        
        let fReq = NSFetchRequest(entityName: "User")
        
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("Core Data Error!\(error1.description)\n")
            result = nil
        }
        
        for resultItem in result! {
                appDelegate.managedObjectContext!.deleteObject(resultItem as! NSManagedObject)
            }

    }
    
    func removeTasks(){
        
    }
    
    func removeMessages(){
        
    }
}