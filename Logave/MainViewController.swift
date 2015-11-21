//
//  MainController.swift
//  Logave
//
//  Created by Alex on 18.11.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    var slide:SlideMenuController? = nil
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var viewChooser: UISegmentedControl!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var ordersView: UIView!
    
    @IBAction func showMenu(sender: UIBarButtonItem){
        self.slide?.openLeft()
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.slide = appDelegate.slideMenuController
    }
}
