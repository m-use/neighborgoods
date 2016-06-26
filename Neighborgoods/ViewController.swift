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
    @IBOutlet var promotionImage: UIImageView!
    
    var location = CLLocationCoordinate2D()
    var mapItem = MKMapItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        let customFont = UIFont(name: "Helvetica Neue", size: 15.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        displayBusinessInfo()
        displayPromoInfo()
        
        CLGeocoder().geocodeAddressString("\(addresses[promoNum]), \(cities[promoNum]), \(states[promoNum]), \(zips[promoNum])", completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {
                if let p = placemarks?[0] {
                    self.location = p.location!.coordinate
                    self.mapItem = MKMapItem(placemark: MKPlacemark(placemark: p))
                }
            }
        })
    }
    
    func displayBusinessInfo() {
        nameLabel.text = businesses[promoNum]
        addressLabel.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        addressLabel.setTitle("\(addresses[promoNum])\n\(cities[promoNum]), \(states[promoNum]), \(zips[promoNum])", forState: .Normal)
        phoneLabel.setTitle("\(phones[promoNum])", forState: .Normal)
    }
    
    func displayPromoInfo() {
        titleLabel.text = titles[promoNum]
        expirationLabel.text = "Expires \(expirations[promoNum])"
promotionImage.image = downloadedImages[promoNum]
        detailsLabel.text = descriptions[promoNum]
        detailsLabel.contentInset = UIEdgeInsetsMake(-4,-4,-4,-4);
        detailsLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Opens Maps app
    @IBAction func map(sender: AnyObject) {
        mapItem.name = businesses[promoNum]
        mapItem.phoneNumber = phones[promoNum]
        mapItem.url = NSURL(string: "\(urls[promoNum])")
        mapItem.openInMapsWithLaunchOptions(nil)
    }

    // Opens Phone app
    @IBAction func phone(sender: AnyObject) {
let stringArray = phones[promoNum].componentsSeparatedByCharactersInSet(
    NSCharacterSet.decimalDigitCharacterSet().invertedSet)
let simpleNum = stringArray.joinWithSeparator("")
        if let url = NSURL(string: "tel:\(simpleNum)") {
            let application = UIApplication.sharedApplication()
            if application.canOpenURL(url) {
                application.openURL(url)
            }
        } else {
            print("failed")
        }
        
    }
}

