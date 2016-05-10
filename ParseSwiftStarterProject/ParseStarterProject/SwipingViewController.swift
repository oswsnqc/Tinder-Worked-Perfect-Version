//
//  SwipingViewController.swift
//  ParseStarterProject
//
//  Created by Yisen on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Parse

import UIKit





class SwipingViewController: UIViewController {
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var infoLabel: UILabel!
    
    var displayedUserId = ""
    
    
    var xFromCenter : CGFloat = 0
    
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        
        var label = gesture.view!
        
        xFromCenter += translation.x
        
        var scale = min(100 / abs(xFromCenter), 1)
        
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        
        gesture.setTranslation(CGPointZero, inView: self.view)
        
        
        var rotetion: CGAffineTransform = CGAffineTransformMakeRotation(xFromCenter / (self.view.bounds.width / 2))
        
        
        var stretch: CGAffineTransform = CGAffineTransformScale(rotetion, scale, scale)
        
        
        
        label.transform = stretch
        
        
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            
            var acceptedOrRejected = ""
            
            
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "rejected"
                
                
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                
                acceptedOrRejected = "accepted"
            }
            
            
            if acceptedOrRejected != "" {
            
                PFUser.currentUser()?.addUniqueObjectsFromArray([displayedUserId], forKey: acceptedOrRejected)
                
                PFUser.currentUser()?.save()
            
            
            }
            
            
            
           // scale = min(100 / abs(xFromCenter), 1)
            
            
            
            rotetion = CGAffineTransformMakeRotation(0 / 2)
            
            stretch = CGAffineTransformScale(rotetion, scale, scale)
            
            label.transform = stretch
            
            label.center =  CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
            
            updateImage()
            
            
        }
    }

    
    func updateImage()  {
        var query = PFUser.query()
        
        if let latitude = PFUser.currentUser()?["location"]?.latitude  {
            
            if let longitude = PFUser.currentUser()?["location"]?.longitude{
        
            query?.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 1, longitude: longitude - 1), toNortheast: PFGeoPoint(latitude: latitude + 1, longitude: longitude + 1))
            }
        }
        var interestedIn = "male"
        
        
        if PFUser.currentUser()?["interestedinWomen"] as! Bool == true {
            
            
            interestedIn = "female"
            
        }
        
        var isFemale = true
        
        if PFUser.currentUser()?["gender"] as! String == "male"  {
            
            isFemale = false
        }
        
        
        query?.whereKey("gender", equalTo: interestedIn)
        query?.whereKey("interestedinWomen", equalTo: isFemale)
        
        var ignoredUsers = [""]
        
        
        if let acceptedUsers: AnyObject = PFUser.currentUser()?["accepted"]{
            
            ignoredUsers += acceptedUsers  as! Array
            
        
        }
        
        if let rejectedUsers: AnyObject = PFUser.currentUser()?["rejected"] {
            
            
            ignoredUsers += rejectedUsers  as! Array

        }
        
        query?.whereKey("objectId", notContainedIn: ignoredUsers)


        
       
        query?.limit = 1
        
        
        
        
        query?.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil {
                
                println(error)
            } else if let objects = objects as? [PFObject] {
                
                for object in objects {
                    
                    
                    self.displayedUserId = object.objectId!
                    
                    let imageFile = object["image"] as! PFFile
                    
                    
                    imageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            
                            println(error)
                        } else {
                            
                            if let data = imageData {
                                
                                self.userImage.image = UIImage(data: data)
                                
                                
                            }
                            
                            
                            
                        }
                        
                    })
                    
                    
                    
                    
                }
                
                
            }
            
        })

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        
        userImage.addGestureRecognizer(gesture)
        
        userImage.userInteractionEnabled = true
        
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            
            if let geoPoint = geoPoint {
                
                PFUser.currentUser()?["location"] = geoPoint
                
                PFUser.currentUser()?.save()
                
                
                
            }
        }
        
        updateImage()
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
            
            PFUser.logOut()

        }
        
        
        
    }
    
    
    
    
    
    

}
