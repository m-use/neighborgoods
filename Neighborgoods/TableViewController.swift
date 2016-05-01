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

var promotions = [Dictionary<String,String>]()
var promoNum = -1

class TableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var cityName:String = ""
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let product = PFObject(className: "Products")
//        product["name"] = "Soda"
//        product["description"] = "CocaCola"
//        product["price"] = "1.99"
//        product.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success == true {
//                print("Object save with ID \(product.objectId)")
//            } else {
//                print("Fail")
//                print(error)
//            }
//        }

        
        
        navStyle()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        promotions.append(["business":"Bread Basket Bakery","address":"4436 N. Miller Rd. Ste 102","city":"Scottsdale","state":"AZ","zip":"85251","phone":"(480) 423-0113","url":"http://breadbasketbakeryscottsdale.com/","title":"Buy Two Loaves, Get One Free!","expiration":"May 13, 2016","details":"For every two loaves of bread you buy here at Bread Basket Bakery, you get one loaf of equal or lesser value free. Our bread is made fresh onsite every morning, so come check us out!"])
        promotions.append(["business":"Bread Basket Bakery","address":"12956 E. Sahuaro Dr.","city":"Scottsdale","state":"AZ","zip":"85259","phone":"(480) 423-0113","url":"http://breadbasketbakeryscottsdale.com/","title":"Buy Two Loaves, Get One Free!!!","expiration":"May 13, 2016","details":"For every two loaves of bread you buy here at Bread Basket Bakery, you get one loaf of equal or lesser value free. Our bread is made fresh onsite every morning, so come check us out!!!"])
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return promotions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = promotions[indexPath.row]["title"]

        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        promoNum = indexPath.row
        return indexPath
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func navStyle() {
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.32, green:0.82, blue:0.53, alpha:1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
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
                    
                    self.cityName = "\(locality)"
                    
                    
                }
                
            }
            
            
        })
        manager.stopUpdatingLocation()
    }

}
