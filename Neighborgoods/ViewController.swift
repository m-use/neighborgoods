//
//  ViewController.swift
//  Neighborgoods
//
//  Created by Lindsey Baker on 4/29/16.
//  Copyright © 2016 Lindsey Baker. All rights reserved.
//

import UIKit
import MapKit

let businessName = "Bread Basket Bakery"
let businessAddress1 = "4436 N. Miller Rd. Ste 102"
let businessAddress2 = "Scottsdale, AZ 85251"
let businessPhone = "(480) 423-0113"
let businessUrl = "http://breadbasketbakeryscottsdale.com/"

class ViewController: UIViewController {
    
    var location = CLLocationCoordinate2D()
    var mapItem = MKMapItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLGeocoder().geocodeAddressString("\(businessAddress1), \(businessAddress2)", completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {
                if let p = placemarks?[0] {
                    self.location = p.location!.coordinate
                    self.mapItem = MKMapItem(placemark: MKPlacemark(placemark: p))
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Opens Maps app
    @IBAction func map(sender: AnyObject) {
        mapItem.name = businessName
        mapItem.phoneNumber = businessPhone
        mapItem.url = NSURL(string: businessUrl)
        mapItem.openInMapsWithLaunchOptions(nil)
    }

}

