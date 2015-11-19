//
//  JsonParserHelper.swift
//  Logave
//
//  Created by Alex on 12.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

class JsonParserHelper{
    static func getUserFromData(data: NSMutableData) -> User?{
        let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        let userData:User? = User()
        if let serverData: AnyObject = decodedJson["data"] {
            if let data: AnyObject = serverData["data"] {
                if let sData:String  = data as? String{
                    print(sData)
                    return nil
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
    static func getTasksFrom(data: NSMutableData) -> [Task?]{
        let decodedJson = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! Dictionary<String, AnyObject>
        let userData:[Task?] = [Task?]()
        if let serverData: AnyObject = decodedJson["data"] {
            if let data: AnyObject = serverData["data"] {
                if let sData:String  = data as? String{
                    print(sData)
                    return nil
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
    }
    
}