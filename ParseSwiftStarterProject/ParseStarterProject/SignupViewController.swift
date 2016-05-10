//
//  SignupViewController.swift
//  ParseStarterProject
//
//  Created by Yisen on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class SignupViewController: UIViewController {
    
    @IBAction func save(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedinWomen"] = switchOn123.on
        
        PFUser.currentUser()?.save()
        
    
        
    }
    
    @IBOutlet var switchOn123: UISwitch!
  
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    /*    let urlArray = ["http://static.comicvine.com/uploads/square_small/0/2617/103863-63963-torongo-leela.JPG",
                        "http://www.theunknownpen.com/wp-content/uploads/2013/03/Velma.jpg",
                        "http://digital-art-gallery.com/oid/41/913x1200_8310_SHEro_V2_3d_character_girl_woman_portrait_cartoon_picture_image_digital_art.jpg",
                        "http://www.smosh.com/sites/default/files/ftpuploads/bloguploads/0713/weird-cartoon-character-gilrs-fb.jpg",
                        "http://www.pieway.com/wp-content/uploads/2011/09/attractive-female-cartoon-characters-05-520x650.jpg",
                        "http://www.cliparthut.com/clip-arts/159/disney-lilo-stitch-159123.jpg",
                        "http://images.t-nation.com/forum_images/auto/r/350x0/3/4/347532.1063401015074.rainbow.gif",
                        "https://filmfork-cdn.s3.amazonaws.com/content/tauriel.jpg",
                        "http://www.dwalls.com/128179-2/female-fantasy-characters-37.jpg",
                        "http://www.123galaxys4wallpapers.com/wp-content/uploads/People/Female%20characters%20ID58.jpg",
                        "http://www.fansshare.com/media/content1/550x298_Emma-Stone-talks-strong-female-characters-in-Hollywood-8310.jpg"]
        
        
        var counter = 1
        
        
        for url in urlArray {
            
            let nsUrl = NSURL(string: url)!
            
            
            if let data = NSData(contentsOfURL: nsUrl)  {
                
                self.image.image = UIImage(data: data)
                
                let imageFile: PFFile = PFFile(data: data)
                
                
                var usersss: PFUser = PFUser()
                
                var username = "user\(counter)"
                
                usersss.username = username
                
                usersss.password = "pass"
                
                
                
                usersss["image"] = imageFile
                
                usersss["interestedinWomen"] = false
                
                usersss["gender"] = "female"
                
                
                counter++ 
                
                usersss.signUp()
                
            }

            
            
            
            
        }  */
        
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"])
        
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                
                println(error)
                
            } else if let result: AnyObject = result {
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?["email"] = result["email"]
                
                
                PFUser.currentUser()?.save()
                
                var userId = result["id"] as! String
                
                
                var facebookProfilePictureUrl = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicurl = NSURL(string: facebookProfilePictureUrl)  {
                    
                    if let data = NSData(contentsOfURL: fbpicurl)  {
                        
                        self.image.image = UIImage(data: data)
                        
                        let imageFile: PFFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["image"] = imageFile
                        
                        PFUser.currentUser()?.saveInBackground()
                        
                    }
                    
                    
                }
                

            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    

}



