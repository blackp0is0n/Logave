//
//  UISwitchCell.swift
//  Logave
//
//  Created by Andrew Johnsson on 17.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class UISwitchCell:UITableViewCell{
    func setSwitch(){
        let switchDisclosure = UISwitch()
        self.accessoryView = switchDisclosure
    }
}