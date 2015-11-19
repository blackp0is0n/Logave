//
//  MapController.swift
//  Logave
//
//  Created by Andrew Johnsson on 16.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//

import UIKit
import MapKit

class TaskAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var location: CLLocationCoordinate2D
    var info: String
    
    init(title: String,subtitle: String, coordinates: CLLocationCoordinate2D, info: String){
        self.title = title
        self.subtitle = subtitle
        self.location = coordinates
        self.info = info
    }
    
    var coordinate: CLLocationCoordinate2D{
        return location
    }
}

class MapController:UIViewController, MKMapViewDelegate{
    let location = CLLocationManager()
    
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
        mapView.delegate = self
        if CLLocationManager.locationServicesEnabled(){
            self.location.requestAlwaysAuthorization()
            self.location.requestWhenInUseAuthorization()
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
        //------------------------------
        /*let urlPath: String = "http://api.logave.com/task/gettask?device=c21592b180d10e601f2080111fc657de&email="
        
        let pather:String = urlPath + String(format: "\(username!)&password=\(password!.md5())")
        
        print(pather)
        self.data = NSMutableData()
        let url: NSURL = NSURL(string: pather)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()*/
        //---------------
        let first = TaskAnnotation(title: "First", subtitle: "blabla", coordinates: CLLocationCoordinate2D(latitude: 53.911976, longitude: 27.594751), info: "Big Boss")
        let second = TaskAnnotation(title: "Second", subtitle: "blabla", coordinates: CLLocationCoordinate2D(latitude: 53.111976, longitude: 27.594751), info: "Tim Cock")
        mapView.addAnnotations([first, second])
        mapView.showsUserLocation = true
    }
}
