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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let businessName = "Bread Basket Bakery"
        let businessAddress1 = "4436 N. Miller Rd."
        let businessAddress2 = "Scottsdale, AZ 85251"
        
        CLGeocoder().geocodeAddressString("\(businessAddress1), \(businessAddress2)", completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {
                if let p = placemarks?[0] {
                    let latitude = p.location!.coordinate.latitude
                    let longitude = p.location!.coordinate.longitude
                    let businessCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = businessCoordinate
                    annotation.title = businessName
                    annotation.subtitle = businessAddress1
                    self.map.addAnnotation(annotation)
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


}

