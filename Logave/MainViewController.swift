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
    
    var message:String?
    
    @IBOutlet weak var dateLabel: UIBarButtonItem!
    @IBOutlet weak var viewChooser: UISegmentedControl!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var ordersView: UIView!
    
    @IBAction func setDate(segue: UIStoryboardSegue){
        let popover = segue.sourceViewController as! DatePickerPopoverController
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.dateLabel.title = dateFormatter.stringFromDate(popover.selectedDate!)
    }
    
    @IBAction func locatePressed(sender: AnyObject) {
    }
    
    @IBAction func showMenu(sender: AnyObject){
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
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverSegue" {
            let popoverViewController = segue.destinationViewController 
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.slide = appDelegate.slideMenuController
    }
}
