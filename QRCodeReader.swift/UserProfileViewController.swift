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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func addSnapchat(_ sender: AnyObject) {
        let instURL: NSURL = NSURL (string: "http://www.snapchat.com/add/s_shaffer56")!
        let instWB: NSURL = NSURL (string: "http://www.snapchat.com/add/s_shaffer56")!
        

        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Snapchat application
            
            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
            
        }
        
    }
    
    
    @IBAction func addFacebook(_ sender: AnyObject) {
        if let url = URL(string: "http://m.facebook.com/tauziet") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("Open \("http://m.facebook.com/tauziet"): \(success)")
                    UIApplication.shared.openURL(url as URL)

                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func followInstagram(_ sender: AnyObject) {
        var instURL: NSURL = NSURL (string: "instagram://user?username=mattogus")! // Replace = Instagram by the your instagram user name
        var instWB: NSURL = NSURL (string: "https://instagram.com/mattogus/")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application

            UIApplication.shared.openURL(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.openURL(instWB as URL)
            
            
            
        }
    }
    
    
    @IBAction func followTwitter(_ sender: AnyObject) {
        if let url = URL(string: "twitter://user?screen_name=logic301") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("Open \("twitter://user?screen_name=logic301"): \(success)")
                    UIApplication.shared.openURL(url as URL)
                    
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    
}
