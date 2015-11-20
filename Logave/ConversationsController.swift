//
//  ConversationsController.swift
//  Logave
//
//  Created by Andrew Johnsson on 16.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class ConversationsController: UIViewController{
    
    @IBOutlet var conversationView: UIView!
    @IBOutlet weak var composeField: UITextField!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: {
            self.bottom.constant = 0
            }, completion: nil)
    }
    
    func keyboardWillShow(sender: NSNotification){
        if let kbHeight = sender.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height{
            self.bottom.constant = kbHeight
            UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        composeField.autoresizingMask = .FlexibleWidth
        super.viewDidLoad()
    }
}
