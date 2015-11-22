//
//  SideMenuController.swift
//  Logave
//
//  Created by Andrew Johnsson on 22.11.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit

class SideMenuController: UITableViewController{
    var tasksController:UINavigationController? = nil
    var messagesController:UINavigationController? = nil
    var slidecontroller:SlideMenuController? = nil
    var settingsController:UINavigationController? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let menuItems = ["Tasks","Messages","Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.frame
        blurView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        view.addSubview(blurView)
        searchBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.sendSubviewToBack(blurView)
        
        let settingsBtn:UIButton = UIButton(type: .Custom)
        settingsBtn.titleLabel?.text = "Settings"
        
        settingsBtn.frame = CGRect(x: 10, y: (view.frame.height-35), width: 75, height: 25)
        settingsBtn.tintColor = UIColor.whiteColor()
        settingsBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        settingsBtn.setTitle("Settings", forState: .Normal)
        view.addSubview(settingsBtn)
        view.bringSubviewToFront(settingsBtn)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as UITableViewCell!
        cell.textLabel!.text = menuItems[indexPath.row]
        
        let eff = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: eff)
        blurView.frame = cell.bounds
        cell.addSubview(blurView)
        let vibView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: eff))
        vibView.frame = blurView.bounds
        vibView.contentView.addSubview(cell.textLabel!)
        blurView.contentView.addSubview(vibView)
        
        //self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            print("0 is selected")
            self.slidecontroller?.changeMainViewController(tasksController!, close: true)
        case 1:
            print("1 selected")
            self.slidecontroller?.changeMainViewController(messagesController!, close: true)
        case 2:
            print("2 selected")
            self.slidecontroller?.changeMainViewController(settingsController!, close: true)
        default:
            print("Default")
        }
    }
    
}
