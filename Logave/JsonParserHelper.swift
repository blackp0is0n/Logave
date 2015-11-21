//
//  JsonParserHelper.swift
//  Logave
//
//  Created by Alex on 12.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

class JsonParserHelper{
    
    
    private init(){}
    
    
    static func getUserFromData(data: NSMutableData) -> User?{
        let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        let userData:User? = User()
        if let serverData: AnyObject = decodedJson["data"] {
            if let data: AnyObject = serverData["data"] {
                if let _:String  = data as? String{
                    
                    return userData
                }
                if let user: AnyObject? = data["user"]{
                    userData?.key = user!["key"] as! String
                    userData?.email = user!["email"] as! String
                    userData?.expDate = user!["expdate"] as! String
                    let str = user!["id"] as! String
                    userData?.id = str
                    userData?.keyDate = user!["keydate"] as! String
                    userData?.name = user!["name"] as! String
                    userData?.sName = user!["sname"] as! String
                    return userData
                }
                
            }
        }
        return nil
    }
    static func getTasks(data: NSMutableData)->[Task]{
        let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        var tasksArray:[Task] = [Task]()
        if let serverData = decodedJson["data"] as? NSDictionary{
            if let tasks = serverData["task"] as? NSArray{
                for index in tasks{
                    let task = Task()
                    
                    task.id = (index["id"] as! NSString).integerValue
                    task.managerId = (index["manager_id"] as! NSString).integerValue
                    task.courierId = (index["courier_id"] as! NSString).integerValue
                    task.description = index["description"] as? String
                    task.address = index["address"] as? String
                    task.name = index["name"] as? String
                    task.sName = index["sname"] as? String
                    task.phone = index["phone"] as? String
                    task.coordinates = (index["coordinats"] as! String).splitToArray()
                    let myDate = index["date"] as? String
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.dateFromString(myDate!)
                    task.date = date
                    tasksArray.append(task)
                    
                }
            } else {
                if let _ = serverData["task"] as? String{
                    //print(noTasks)
                }
                
            }
        }
        return tasksArray
    }
    static func getKey(data:NSData)->String{
        let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        if let jsonData = decodedJson["data"] as? NSDictionary{
            if let key = jsonData["key"] as? String{
                return key
            } else {
                return ""
            }
            
        } else {
            return ""
        }
    }
    
    static func getMessages(data: NSData) ->[Message]{
        //let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        
        return []
    }
    
}