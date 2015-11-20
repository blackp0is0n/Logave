//
//  MainController.swift
//  Logave
//
//  Created by Alex on 18.11.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBAction func showSettings(sender: AnyObject) {
        let settings = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .ActionSheet)
        
        settings.addAction(UIAlertAction(title: "Settings", style: .Default, handler: {
            action in
            self.performSegueWithIdentifier("toggleSettings", sender: nil)
        }))
        
        settings.addAction(UIAlertAction(title: "Orders", style: .Default, handler: {
            action in
            self.performSegueWithIdentifier("toggleOrders", sender: nil)
        }))
        
        settings.addAction(UIAlertAction(title: "Cancel", style: .Cancel){action -> Void in})
        
        self.presentViewController(settings, animated: true, completion: nil)
    }
    
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var viewChooser: UISegmentedControl!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var ordersView: UIView!
    
    @IBAction func changeView(sender: AnyObject) {
        switch (viewChooser.selectedSegmentIndex){
        case 0:
            self.ordersView.hidden = true
            self.mapView.hidden = false
            break
        case 1:
            self.mapView.hidden = true
            self.ordersView.hidden = false
            break
        default:
            break
        }
    }
    
    @IBAction func showDatePicker(sender: AnyObject) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        
        let pickerController = UIViewController()
        pickerController.view.addSubview(datePicker)
        pickerController.preferredContentSize = datePicker.frame.size
        pickerController.modalPresentationStyle = .Popover
        
        let popover = pickerController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceRect = pickerButton.bounds
        popover?.sourceView = pickerButton
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}
