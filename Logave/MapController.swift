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
    var annotations:[TaskAnnotation] = [TaskAnnotation]()
    @IBOutlet weak var mapView: MKMapView!
    var data: NSMutableData = NSMutableData()
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
        let urlPath: String = "http://api.logave.com/task/gettask?device=c21592b180d10e601f2080111fc657de&key="
        
        let pather:String = urlPath + CoreDataController.getUser()!.key + "&date=2015-09-05"
        
        //print(pather)
        self.data = NSMutableData()
        let url: NSURL = NSURL(string: pather)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()
        //---------------
        // first = TaskAnnotation(title: "First", subtitle: "blabla", coordinates: CLLocationCoordinate2D(latitude: 53.911976, longitude: 27.594751), info: "Big Boss")
        // second = TaskAnnotation(title: "Second", subtitle: "blabla", coordinates: CLLocationCoordinate2D(latitude: 53.111976, longitude: 27.594751), info: "Tim Cock")
        //mapView.addAnnotations([first, second])
        mapView.showsUserLocation = true
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    func showAlert(title: String,message: String){
        let alertController = UIAlertController(title: title,message:message, preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController,animated:true,completion:nil)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error:NSError! ){
        showAlert("Issue",message: "Check your internet connection")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let key:String = JsonParserHelper.getKey(data)
        let tasks:[Task] = JsonParserHelper.getTasks(data)
        //CoreDataController.setTasks(tasks)
        if tasks.count > 0 {
            for index in tasks{
                var annotation = TaskAnnotation(title: index.address!, subtitle: index.name!, coordinates: CLLocationCoordinate2D(latitude: index.coordinates[0], longitude: index.coordinates[1]),info: "task")
                annotations.append(annotation)
            }
            mapView.addAnnotations(annotations)
            //var datastring = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
            print(key)
            //performSegueWithIdentifier("authCompleted", sender: self)
        } else {
            showAlert("Error", message: "Re-Check Your Credentials")
        }
        
    }
}
