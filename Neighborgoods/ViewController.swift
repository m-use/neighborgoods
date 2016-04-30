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

let promoTitle = "Buy Two Loaves, Get One Free!"
let promoExpiration = "May 5, 2016"
let promoDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel dolor magna. Etiam bibendum scelerisque risus. Mauris pharetra lobortis ipsum non fringilla. Sed id nisl non massa tincidunt euismod a nec nunc. In vehicula leo vitae ex laoreet, at placerat neque egestas. Nullam sodales massa ligula, sed luctus ipsum sodales quis. Ut id odio eu massa ultricies interdum et vel dui. Curabitur laoreet risus nec vulputate placerat.\n\nPhasellus sollicitudin dui sit amet maximus ultricies. Pellentesque consectetur aliquam gravida. Proin in diam porta, condimentum justo eget, pulvinar orci. Quisque sed odio sed mi venenatis dapibus a nec ipsum. Praesent eu tincidunt orci. Donec pharetra felis eget risus aliquam porttitor. Quisque laoreet urna in lacus facilisis lobortis quis ut quam. \n\nMorbi porttitor rhoncus felis ut porta. Aenean tristique odio et enim egestas, ut placerat mauris venenatis. Nullam fringilla metus eget libero dapibus, vel bibendum mauris lobortis. Proin porttitor vel sem vel iaculis. Cras a erat ut augue viverra aliquam et nec dui. Sed accumsan lobortis mi, quis rhoncus justo pulvinar non. Fusce orci velit, feugiat nec placerat sed, pharetra volutpat purus. Nam augue turpis, gravida nec lobortis nec, tincidunt ut tortor. Donec vitae porta erat, sed interdum libero. Aliquam viverra porttitor neque ac finibus. Donec ultrices iaculis sapien, sit amet semper lorem fermentum eget.\n\nNunc vitae facilisis diam, quis tristique nibh. In elementum eros felis, pellentesque ullamcorper eros elementum ut. Fusce facilisis purus fringilla urna vehicula, ut ultrices justo rhoncus. Aliquam mattis urna ac urna commodo, sit amet aliquam odio euismod. Nulla vitae sodales neque. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. \n\nDonec dictum, est id accumsan imperdiet, erat mauris tincidunt nulla, sed semper eros quam quis erat. Vestibulum sit amet justo eget turpis mollis auctor. Fusce nec venenatis tortor. Nullam viverra eros a lectus sodales, vel sodales neque placerat. Vestibulum ornare ex sit amet turpis convallis dictum eu non turpis. Donec quis dolor enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit."

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
        displayBusinessInfo()
        displayPromoInfo()
        
        CLGeocoder().geocodeAddressString("\(businessAddress1), \(businessAddress2)", completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {
                if let p = placemarks?[0] {
                    self.location = p.location!.coordinate
                    self.mapItem = MKMapItem(placemark: MKPlacemark(placemark: p))
                }
            }
        })
    }
    
    func displayBusinessInfo() {
        nameLabel.text = businessName
        addressLabel.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        addressLabel.setTitle("\(businessAddress1)\n\(businessAddress2)", forState: .Normal)
        phoneLabel.setTitle("\(businessPhone)", forState: .Normal)
    }
    
    func displayPromoInfo() {
        titleLabel.text = promoTitle
        expirationLabel.text = promoExpiration
        detailsLabel.text = promoDescription
        detailsLabel.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
        detailsLabel.sizeToFit()
        
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

