//
//  ViewController.swift
//  Neighborgoods
//
//  Created by Lindsey Baker on 4/29/16.
//  Copyright © 2016 Lindsey Baker. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

let businessName = "Bread Basket Bakery"
let businessAddress1 = "4436 N. Miller Rd. Ste 102"
let businessAddress2 = "Scottsdale, AZ 85251"
let businessPhone = "(480) 423-0113"
let businessUrl = "http://breadbasketbakeryscottsdale.com/"
var location = CLLocationCoordinate2D()

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    var mapItem = MKMapItem()

    override func viewDidLoad() {
        super.viewDidLoad()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        CLGeocoder().geocodeAddressString("\(businessAddress1), \(businessAddress2)", completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {
                if let p = placemarks?[0] {
                    location = p.location!.coordinate
                    let businessCoordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = businessCoordinate
                    annotation.title = businessName
                    annotation.subtitle = businessAddress1
                    self.map.addAnnotation(annotation)
                    
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegionMake(location, span)
                    self.map.setRegion(region, animated: true)
                    
                    self.mapItem = MKMapItem(placemark: MKPlacemark(placemark: p))

                }
            }
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        myPosition = newLocation.coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(newLocation.coordinate, span)
        map.setRegion(region, animated: true)
        // locationManager.stopUpdatingLocation()
    }
    
    @IBAction func directions(sender: AnyObject) {
        print("\(location.latitude), \(location.longitude)")
        mapItem.name = businessName
        mapItem.phoneNumber = businessPhone
        mapItem.url = NSURL(string: businessUrl)
        mapItem.openInMapsWithLaunchOptions(nil)
        
    }


}

