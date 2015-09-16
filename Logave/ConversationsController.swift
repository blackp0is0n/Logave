//
//  ConversationsController.swift
//  Logave
//
//  Created by Andrew Johnsson on 16.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class ConversationsController: UIViewController{
    @IBOutlet weak var composeField: UITextField!
    override func viewDidLoad() {
        composeField.autoresizingMask = .FlexibleWidth
        super.viewDidLoad()
    }
}
