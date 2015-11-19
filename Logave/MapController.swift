//
//  MapController.swift
//  Logave
//
//  Created by Andrew Johnsson on 16.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController:UIViewController{
    
    let location = CLLocationManager()
    var pinnotation: MKPointAnnotation
    let pin = CLLocationCoordinate2D(latitude: 53.911976, longitude: 27.594751)
    
    @IBOutlet weak var mapView: MKMapView!
    
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
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "task"
        
        if annotation.isKindOfClass(TaskAnnotation.self){
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let orderDetailsButton = UIButton(type: .InfoLight)
                annotationView!.rightCalloutAccessoryView = orderDetailsButton
            }
            else{
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let task = view.annotation as! TaskAnnotation
        /*let taskName = task.title
        let taskInfo = task.info*/
        
        self.performSegueWithIdentifier("showOrderDetails", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled(){
            self.location.requestAlwaysAuthorization()
            self.location.requestWhenInUseAuthorization()
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
        pinnotation.coordinate = pin
        pinnotation.title = "Гикало" +  "9"
        pinnotation.subtitle = "Big Boss"
        mapView.addAnnotation(pinnotation)
        mapView.showsUserLocation = true
    }    
}
