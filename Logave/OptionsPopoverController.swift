//
//  OptionsPopoverController.swift
//  Logave
//
//  Created by Andrew Johnsson on 22.11.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class OptionsPopoverController: UIViewController{
    
    var selectedMode:Int?
    
    @IBOutlet weak var mapModeSelector: UISegmentedControl!
    
    @IBAction func modeSelected(sender: AnyObject) {
        self.selectedMode = mapModeSelector.selectedSegmentIndex
    }
}
