//
//  SideMenuController.swift
//  Logave
//
//  Created by Andrew Johnsson on 17.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class SideMenuController:UITableViewController{
    
    func addBlur(){
        let blurredView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: .Light))) as UIVisualEffectView
        blurredView.frame = (self.navigationController?.navigationBar.bounds)!
        blurredView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 170, green: 170, blue: 170, alpha: 1)
        self.navigationController?.navigationBar.addSubview(blurredView)
        self.navigationController?.navigationBar.sendSubviewToBack(blurredView)
    }
    
    override func viewDidLoad() {
        addBlur();
        self.navigationItem.hidesBackButton = true
    }
}
