//
//  Task.swift
//  Logave
//
//  Created by Alex on 12.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

class Task{
    var id:Int = 0
    var managerId:Int = 0
    var courierId:Int = 0
    var address:String? = nil
    var coordinates:[Double] = []
    var description:String? = nil
    var name:String? = nil
    var sName:String? = nil
    var phone:String? = nil
    var active:Bool? = nil
    var date:NSDate? = nil
}