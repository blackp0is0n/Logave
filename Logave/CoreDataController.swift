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
    
    private init(){}
    static let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    static func setTasks(tasks:[Task]){
        removeTasks()
        for index in tasks{
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: appDelegate.managedObjectContext!)
            newManagedObject.setValue(Int(index.id), forKey: "id")
            newManagedObject.setValue(Int(index.managerId), forKey: "manager_id")
            newManagedObject.setValue(Int(index.courierId), forKey: "courier_id")
            newManagedObject.setValue(NSNumber(double: index.coordinates[0]), forKey: "latitude")
            newManagedObject.setValue(NSNumber(double: index.coordinates[1]), forKey: "longtitude")
            newManagedObject.setValue(index.name, forKey: "reciever_name")
            newManagedObject.setValue(index.sName, forKey: "reciever_sname")
            newManagedObject.setValue(index.phone, forKey: "reciever_phone")
            newManagedObject.setValue(index.address, forKey: "address")
            newManagedObject.setValue(index.description, forKey: "task_description")
            newManagedObject.setValue(index.active, forKey: "isActive")
            newManagedObject.setValue(index.date, forKey: "taskDate")
            appDelegate.saveContext()
        }
        
    }
    
    static func addTask(task:Task){
        if !taskExists(task){
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: appDelegate.managedObjectContext!)
            newManagedObject.setValue(Int(task.id), forKey: "id")
            newManagedObject.setValue(Int(task.managerId), forKey: "manager_id")
            newManagedObject.setValue(Int(task.courierId), forKey: "courier_id")
            newManagedObject.setValue(Double(task.coordinates[0]), forKey: "latitude")
            newManagedObject.setValue(Double(task.coordinates[1]), forKey: "longtitude")
            newManagedObject.setValue(task.name, forKey: "reciever_name")
            newManagedObject.setValue(task.sName, forKey: "reciever_sname")
            newManagedObject.setValue(task.phone, forKey: "reciever_phone")
            newManagedObject.setValue(task.address, forKey: "address")
            newManagedObject.setValue(task.description, forKey: "task_description")
            newManagedObject.setValue(task.active, forKey: "isActive")
            newManagedObject.setValue(task.date, forKey: "taskDate")
            appDelegate.saveContext()
        }
    }
    
    static func setSafeUser(user:User){
        removeUser()
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
        
        newManagedObject.setValue(user.name, forKey: "name")
        newManagedObject.setValue(user.sName, forKey: "sName")
        newManagedObject.setValue(user.keyDate, forKey: "keyDate")
        newManagedObject.setValue(user.key, forKey: "key")
        newManagedObject.setValue(user.name, forKey: "email")
        newManagedObject.setValue(user.expDate, forKey: "expDate")
        newManagedObject.setValue(String(user.id), forKey: "id")
        appDelegate.saveContext()
    }
    static func taskExists(task:Task)-> Bool{
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "Task")
        fReq.predicate = NSPredicate(format: "id = %d", task.id)
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("Core Data Error!\(error1.description)\n")
            result = nil
        }
        appDelegate.saveContext()
        if result?.count>0 {
            return true
        } else {
            return false
        }
    }
    
    static func setUser(user:User){//remove all users from database and adding new user
        removeMessages()
        removeTasks()
        removeUser()
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
        
        newManagedObject.setValue(user.name, forKey: "name")
        newManagedObject.setValue(user.sName, forKey: "sName")
        newManagedObject.setValue(user.keyDate, forKey: "keyDate")
        newManagedObject.setValue(user.key, forKey: "key")
        newManagedObject.setValue(user.name, forKey: "email")
        newManagedObject.setValue(user.expDate, forKey: "expDate")
        newManagedObject.setValue(user.id, forKey: "id")
        appDelegate.saveContext()
    }
    
    static func getUser() -> User{//getting existing user from database
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
            user.name = resultItem.valueForKey("name") as! String
            user.sName = resultItem.valueForKey("sName") as! String
            user.key = resultItem.valueForKey("key") as! String
            user.keyDate = resultItem.valueForKey("keyDate") as! String
            user.email = resultItem.valueForKey("email") as! String
            let stringer =  resultItem.valueForKey("id") as! String
            user.id = stringer
            //NSLog(stringer)
        }
        appDelegate.saveContext()
        return user
    }
    
    
    
    static func getMessages() -> [Message?]{//Must be completed!!!!!!!!!
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
            user.name = resultItem.valueForKey("name") as! String
            user.sName = resultItem.valueForKey("sName") as! String
            user.key = resultItem.valueForKey("key") as! String
            user.keyDate = resultItem.valueForKey("keyDate") as! String
            user.email = resultItem.valueForKey("email") as! String
        }
        return []
    }
    
    static func getTasks(date: NSDate)-> [Task]{
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "Task")
        fReq.predicate = NSPredicate(format: "taskDate == %@", date)
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("Core Data Error!\(error1.description)\n")
            result = nil
        }
        print("From core data controller:"+String(result?.count))
        var tasks = [Task]()
        for resultItem in result! {
            let task = Task()
            NSLog("ID is %d", task.id)
            task.id = (resultItem.valueForKey("id") as? Int)!
            task.managerId = (resultItem.valueForKey("manager_id") as? Int)!
            task.courierId = (resultItem.valueForKey("courier_id") as? Int)!
            task.name = resultItem.valueForKey("reciever_name") as? String
            task.sName = resultItem.valueForKey("reciever_sname") as? String
            task.phone = resultItem.valueForKey("reciever_phone") as? String
            task.description = resultItem.valueForKey("task_description") as? String
            task.active = resultItem.valueForKey("isActive") as? Bool
            task.address = resultItem.valueForKey("address") as? String
            task.coordinates[0] = (resultItem.valueForKey("latitude") as? Double)!
            task.coordinates[1] = (resultItem.valueForKey("longtitude") as? Double)!
            task.date = resultItem.valueForKey("taskDate") as? NSDate
            tasks.append(task)
        }
        appDelegate.saveContext()
        return tasks
    }
    
    static func getAllTasks() -> [Task]{//deprecated method
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "Task")
        
        //var messages = [Message?]()
        var result: [AnyObject]?
        do {
            result = try appDelegate.managedObjectContext!.executeFetchRequest(fReq)
        } catch let error1 as NSError {
            print("Core Data Error!\(error1.description)\n")
            result = nil
        }
        var tasks = [Task]()
        for resultItem in result! {
            let task = Task()
            task.id = (resultItem.valueForKey("id") as? Int)!
            task.managerId = (resultItem.valueForKey("manager_id") as? Int)!
            task.courierId = (resultItem.valueForKey("courier_id") as? Int)!
            task.name = resultItem.valueForKey("reciever_name") as? String
            task.sName = resultItem.valueForKey("reciever_sname") as? String
            task.phone = resultItem.valueForKey("reciever_phone") as? String
            task.description = resultItem.valueForKey("task_description") as? String
            task.active = resultItem.valueForKey("isActive") as? Bool
            task.address = resultItem.valueForKey("address") as? String
            task.coordinates[0] = (resultItem.valueForKey("latitude") as? Double)!
            task.coordinates[1] = (resultItem.valueForKey("longtitude") as? Double)!
            task.date = resultItem.valueForKey("taskDate") as? NSDate
            tasks.append(task)
        }
        appDelegate.saveContext()
        return tasks
    }
    
    static func setKey(key:String){
        let user = getUser()
        user.key = key
        removeUser()
        
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
        NSLog("%@ \n %@ \n", user.id , user.id)
        newManagedObject.setValue(user.name, forKey: "name")
        newManagedObject.setValue(user.sName, forKey: "sName")
        newManagedObject.setValue(user.keyDate, forKey: "keyDate")
        newManagedObject.setValue(user.key, forKey: "key")
        newManagedObject.setValue(user.name, forKey: "email")
        newManagedObject.setValue(user.expDate, forKey: "expDate")
        newManagedObject.setValue(user.id, forKey: "id")
        appDelegate.saveContext()
    }
    static func removeUser(){//remove all users in a database
        
        removeAllEntities("User")
        
    }
    
    
    
    static func removeTasks(){
        removeAllEntities("Task")
    }
    
    
    
    static func removeMessages(){
        removeAllEntities("Message")
    }
    
    
    static func removeAllEntities(entity:String?){
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
        appDelegate.saveContext()
    }
}