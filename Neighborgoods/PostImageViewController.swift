//
//  PostImageViewController.swift
//  Neighborgoods
//
//  Created by Lindsey Baker on 5/1/16.
//  Copyright © 2016 Lindsey Baker. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBAction func chooseImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
    
    }
    
    @IBOutlet var promoId: UITextField!
    
    @IBAction func postImage(sender: AnyObject) {
        
        var query = PFQuery(className: "Promotions")
        query.getObjectInBackgroundWithId(promoId.text!) { (object:PFObject?, error: NSError?) in
            if error != nil {
                print(error)
            } else if let promotion = object {
                
                let imageData = UIImagePNGRepresentation(self.imageToPost.image!)
                
                let imageFile = PFFile(name: "image.png", data: imageData!)
                
                promotion["image"] = imageFile
                
                promotion.saveInBackgroundWithBlock { (success, error) in
                    if error == nil {
                        
                        print("success")
                        
                    }
                }

                
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///////// ADDS PROMO TO DATABASE /////////
        //        let promotion = PFObject(className: "Promotions")
        //        promotion["business"] = "Changing Hands Bookstore"
        //        promotion["address"] = "6428 S McClintock Dr"
        //        promotion["city"] = "Tempe"
        //        promotion["state"] = "AZ"
        //        promotion["zip"] = "85283"
        //        promotion["phone"] = "(480) 730-0205"
        //        promotion["url"] = "www.changinghands.com"
        //        promotion["title"] = "Postcard Coloring Books - Buy One, Get One Free!"
        //        promotion["expiration"] = "May 23, 2016"
        //        promotion["description"] = "For a limited time only, choose one from our wide selection of postcard coloring books and get a second for free!"
        //        promotion.saveInBackgroundWithBlock { (success, error) -> Void in
        //            if success == true {
        //                print("Object save with ID \(promotion.objectId)")
        //            } else {
        //                print("Fail")
        //                print(error)
        //            }
        //        }

        var query = PFQuery(className: "Promotions")
        query.getObjectInBackgroundWithId("Vrxvy8LG94") { (object, error) in
            if error != nil {
                print(error)
            } else {
                print(object!.objectForKey("business")!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
