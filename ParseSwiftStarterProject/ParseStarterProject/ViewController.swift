//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit


class ViewController: UIViewController {
    
    @IBAction func signupFacebook(sender: AnyObject) {
        
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            (user: PFUser?, error: NSError?) -> Void in
            
            
            if let error = error {
                
                println(error)
                
            } else {
                
                if let user = user {
                    
                    if let interestedinWomen: AnyObject = user["interestedinWomen"]  {
                        
                        
                        self.performSegueWithIdentifier("logUserIn", sender: self)

                        
                    }  else {
                    
                        self.performSegueWithIdentifier("showSigninScreen", sender: self)
                        
                    }
                    
                }
            }
        })

        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        

        
        if let username = PFUser.currentUser()?.username {
            
    
                
                if let interestedinWomen: AnyObject = PFUser.currentUser()?["interestedinWomen"]  {
                    
                    
                    self.performSegueWithIdentifier("logUserIn", sender: self)
                    
                    
                }  else {
                    
                    self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    
                }
            

            
            
            
            
        }
    }
    
    
    /*
    var xFromCenter : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let push = PFPush()
        push.setChannel("hello")
        push.setMessage("bye")
        push.sendPushInBackground()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var label: UILabel = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
        label.text = "Drag Me"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        
        label.addGestureRecognizer(gesture)
        
        label.userInteractionEnabled = true
        
        
    }
    
    
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
        
        
        if label.center.x < 100 {
            
            
            
        } else if label.center.x > self.view.bounds.width - 100 {
            
            
            
        }
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            label.center =  CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
            
            scale = min(100 / abs(xFromCenter), 1)
            
            rotetion = CGAffineTransformMakeRotation(0 / 2)
            
            stretch = CGAffineTransformScale(rotetion, scale, scale)
            
            label.transform = stretch
            
            
        }
    }  */
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

