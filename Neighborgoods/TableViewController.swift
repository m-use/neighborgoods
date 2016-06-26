//
//  TableViewController.swift
//  Neighborgoods
//
//  Created by Lindsey Baker on 4/30/16.
//  Copyright © 2016 Lindsey Baker. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

var promoNum = -1

var titles = [String]()
var businesses = [String]()
var expirations = [String]()
var addresses = [String]()
var cities = [String]()
var states = [String]()
var zips = [String]()
var phones = [String]()
var urls = [String]()
var descriptions = [String]()
var images = [PFFile]()
var downloadedImages = [UIImage]()

var cityName:String = ""
let cityyy:String = "Scottsdale"

class TableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        
        // print(cityName)
        
        var getPromosQuery = PFQuery(className: "Promotions")
        // getPromosQuery.whereKey("city", equalTo: cityName)
        getPromosQuery.whereKey("state", equalTo: "AZ")
        getPromosQuery.findObjectsInBackgroundWithBlock { (objects, error) in
            if let objects = objects {
                
                for object in objects {
                    
                    titles.append(object["title"] as! String)
                    
                    businesses.append(object["business"] as! String)
                    
                    expirations.append(object["expiration"] as! String)
                    
                    addresses.append(object["address"] as! String)
                    
                    cities.append(object["city"] as! String)
                    
                    states.append(object["state"] as! String)
                    
                    zips.append(object["zip"] as! String)
                    
                    phones.append(object["phone"] as! String)
                    
                    urls.append(object["url"] as! String)
                    
                    descriptions.append(object["description"] as! String)
                    
                    images.append(object["image"] as! PFFile)
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let promoCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
        
        images[indexPath.row].getDataInBackgroundWithBlock { (data, error) in
            if let downloadedImage = UIImage(data: data!) {
                
                promoCell.promotionImage.image = downloadedImage
                
                downloadedImages.append(downloadedImage)
                
            }
        }
        
        promoCell.promotionTitle.text = titles[indexPath.row]
        promoCell.promotionBusiness.text = businesses[indexPath.row]
        promoCell.promotionExpiration.text = "Expires \(expirations[indexPath.row])"
        
        
        return promoCell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        promoNum = indexPath.row
        return indexPath
    }
    
    
        func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
            CLGeocoder().reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) -> Void in
    
                if (error == nil) {
    
                    //if statement was changed
                    if let p = placemarks?[0] {
    
                        var locality:String = ""
    
                        if p.locality != nil {
    
                            locality = p.locality!
                            
                        }
                        
                        cityName = "\(locality)"
                    }
                    
                }
                
            })
            
            manager.stopUpdatingLocation()
            
        }
    
}
