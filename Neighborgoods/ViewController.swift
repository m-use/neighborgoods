//
//  ViewController.swift
//  Neighborgoods
//
//  Created by Lindsey Baker on 4/29/16.
//  Copyright © 2016 Lindsey Baker. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UIButton!
    @IBOutlet var phoneLabel: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var expirationLabel: UILabel!
    @IBOutlet var detailsLabel: UITextView!
    
    var location = CLLocationCoordinate2D()
    var mapItem = MKMapItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = promotions[promoNum]["business"]
        displayBusinessInfo()
        displayPromoInfo()
        
        CLGeocoder().geocodeAddressString("\(promotions[promoNum]["address"]), \(promotions[promoNum]["city"]), \(promotions[promoNum]["state"]), \(promotions[promoNum]["zip"])", completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {
                if let p = placemarks?[0] {
                    self.location = p.location!.coordinate
                    self.mapItem = MKMapItem(placemark: MKPlacemark(placemark: p))
                }
            }
        })
    }
    
    func displayBusinessInfo() {
        nameLabel.text = promotions[promoNum]["business"]
        addressLabel.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        addressLabel.setTitle("\(promotions[promoNum]["address"]!)\n\(promotions[promoNum]["city"]!), \(promotions[promoNum]["state"]!), \(promotions[promoNum]["zip"]!)", forState: .Normal)
        phoneLabel.setTitle("\(promotions[promoNum]["phone"]!)", forState: .Normal)
    }
    
    func displayPromoInfo() {
        titleLabel.text = promotions[promoNum]["title"]
        expirationLabel.text = "Expires \(promotions[promoNum]["expiration"]!)"
        detailsLabel.text = promotions[promoNum]["details"]
        detailsLabel.contentInset = UIEdgeInsetsMake(-4,-4,-4,-4);
        detailsLabel.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Opens Maps app
    @IBAction func map(sender: AnyObject) {
        mapItem.name = promotions[promoNum]["business"]
        mapItem.phoneNumber = promotions[promoNum]["phone"]
        mapItem.url = NSURL(string: "\(promotions[promoNum]["url"]!)")
        mapItem.openInMapsWithLaunchOptions(nil)
    }

    // Opens Phone app
    @IBAction func phone(sender: AnyObject) {
        let url:NSURL = NSURL(string: "tel://\(promotions[promoNum]["phone"])")!
        UIApplication.sharedApplication().openURL(url)
        
    }
}

