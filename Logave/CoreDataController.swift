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
    
    
    func setUser(user:User?){//remove all users from database and adding new user
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
    
    func getUser() -> User?{//getting existing user from database
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
    
    
    
    func getMessages() -> [Message?]{//Must be completed!!!!!!!!!
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "Message")
        
        //var messages = [Message?]()
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
        return []
    }
    
    
    
    func getTasks() -> [Task?]{
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "Task")
        
        //var messages = [Message?]()
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("Core Data Error!\(error1.description)\n")
            result = nil
        }
        var tasks = [Task?]()
        for resultItem in result! {
            let task = Task()
            task.id = resultItem.valueForKey("id") as? Int32
            task.managerId = resultItem.valueForKey("manager_id") as? Int32
            task.courierId = resultItem.valueForKey("courier_id") as? Int32
            task.name = resultItem.valueForKey("reciever_name") as? String
            task.sName = resultItem.valueForKey("reeciever_sname") as? String
            task.phone = resultItem.valueForKey("reciever_phone") as? String
            task.descpription = resultItem.valueForKey("task_description") as? String
            task.active = resultItem.valueForKey("isActive") as? Bool
            task.address = resultItem.valueForKey("address") as? String
            tasks.append(task)
            break
        }
        return tasks
    }
    

    func removeUser(){//remove all users in a database
        
        removeAllEntities("User")

    }
    
    
    
    func removeTasks(){
        removeAllEntities("Task")
    }
    
    
    
    func removeMessages(){
        removeAllEntities("Message")
    }
    
    
    func removeAllEntities(entity:String?){
        let fReq = NSFetchRequest(entityName: entity!)
        
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
}