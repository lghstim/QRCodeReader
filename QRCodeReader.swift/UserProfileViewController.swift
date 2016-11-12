//
//  UserProfileViewController.swift
//  QRCodeReader.swift
//
//  Created by Tim Gorer on 11/11/16.
//  Copyright © 2016 Yannick Loriot. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var snapchatButton: DesignableButton!
    @IBOutlet weak var facebookButton: DesignableButton!
    @IBOutlet weak var instagramButton: DesignableButton!
    @IBOutlet weak var twitterButton: DesignableButton!
    var snapchatName = "";
    var facebookURL = "";
    var twitterName = "";
    var instagramName = "";
    var url = NSURL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("URL:")
        print(self.url)
        self.downloadData()
        
    }

    
    func downloadData()
    {
        let request = NSMutableURLRequest(url: self.url! as URL)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:",error)
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary //because JSON data started with dictionary. Not an array
                    if let twitter = responseString["twitter"] as? String {
                        self.twitterName = twitter
                        print("twitter name:" + "," + self.twitterName)
                    }
                    
                    else {
                        self.twitterButton.isUserInteractionEnabled = false;
                    }
                    if let instagram = responseString["instagram"] as? String {
                        self.instagramName = instagram
                        print("insta name" + "," + self.instagramName)
                    }
                    else {
                        self.instagramButton.isUserInteractionEnabled = false;
                    }
                    if let snapchat = responseString["snapchat"] as? String {
                        self.snapchatName = snapchat
                        print("snapchat name" + "," + self.snapchatName)
                    }
                    else {
                        self.snapchatButton.isUserInteractionEnabled = false;
                    }
                    if let facebook = responseString["facebook"] as? String {
                        self.facebookURL = facebook
                        print("facebook URL" + "," + self.facebookURL)
                    }
                    else {
                        self.facebookButton.isUserInteractionEnabled = false;
                    }
                }
            }
        }
        
        task.resume()
    }
    
  
    @IBAction func addSnapchat(_ sender: AnyObject) {
        let snapchatString = "http://www.snapchat.com/add/" + self.snapchatName
        let instURL: NSURL = NSURL (string: snapchatString)!
        let instWB: NSURL = NSURL (string: snapchatString)!
        

        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Snapchat application
            
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
            
        }
        
    }
    
    
    @IBAction func addFacebook(_ sender: AnyObject) {
        if let url = URL(string: self.facebookURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("Open \(self.facebookURL): \(success)")
                    UIApplication.shared.openURL(url as URL)

                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func followInstagram(_ sender: AnyObject) {
        let instaString = "instagram://user?username=" + self.instagramName

        var instURL: NSURL = NSURL (string: instaString)! // Replace = Instagram by the your instagram user name
        var instWB: NSURL = NSURL (string: instaString)! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application

            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
            
            
            
        }
    }
    
    
    @IBAction func followTwitter(_ sender: AnyObject) {
        let twitterString = "http://www.twitter.com/" + self.twitterName

        var instURL: NSURL = NSURL (string:  twitterString)! // Replace = Instagram by the your instagram user name
        var instWB: NSURL = NSURL (string:  twitterString)! // Replace the link by your instagram weblink
        
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
            
            
            
        }
    }
    
    @IBAction func backButtonDidPress(_ sender: AnyObject) {
        
    }
}
