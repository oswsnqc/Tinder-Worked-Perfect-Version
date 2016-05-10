//
//  ContactViewController.swift
//  ParseStarterProject
//
//  Created by Yisen on 7/29/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse




class ContactViewController: UITableViewController {
    
    
    var emails = [String]()
    var image = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFUser.query()
        query?.whereKey("accepted", equalTo: PFUser.currentUser()!.objectId!)
        query?.whereKey("objectId", containedIn: PFUser.currentUser()?["accepted"] as! [String])
        
        query?.findObjectsInBackgroundWithBlock({ (results, error: NSError?) -> Void in
            
            
            if let results = results {
                
                   for results in results as! [PFUser] {
                    
                
                
                    self.emails.append(results["email"]! as! String)
                    
                    let imageFile = results["image"] as! PFFile
                    
                    
                    imageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            
                            println(error)
                        } else {
                            
                            if let data = imageData {
                                
                                self.image.append(UIImage(data: data)!)
                                
                                self.tableView.reloadData()
                                
                                
                            }
                            
                            
                            
                        }
                        
                    })

                    
                    
                
                }
                
                self.tableView.reloadData()
                
                
                
            }
        })
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AnyObject = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath)
        
        cell.textLabel!!.text = emails[indexPath.row]
        
        
        if image.count > indexPath.row {
            
            cell.imageView??.image = image[indexPath.row]
            
        }
        
        
        
        return cell as! UITableViewCell
        
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let url = NSURL(string: "mailto:" + emails[indexPath.row])
        
        UIApplication.sharedApplication().openURL(url!)
        
        
        
        
        
    }

}
