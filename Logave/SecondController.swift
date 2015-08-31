//
//  SecondController.swift
//  Logave
//
//  Created by Alex on 31.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import UIKit


class SecondController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(self.sayhello("Andryuha!"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sayhello(myName: String) -> String {
        println("Hello,"+myName)
        
        return "Die motherfucker"
    }
    
}