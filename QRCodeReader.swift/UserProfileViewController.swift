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
    @IBOutlet weak var snapchatButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    var snapchatName = "";
    var facebookURL = "";
    var linkedinURL = "";
    var youtubeURL = "";
    var twitterName = "";
    var instagramName = "";
    var emailString = "";
    var nameString = "";
    var phoneNumberInt : Int = 0
    var url = NSURL(string: "")
    
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    
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
                        print("twitter name:" + " " + self.twitterName)
                    }
                    
                    else {
                        self.twitterButton.isUserInteractionEnabled = false;
                    }
                    if let instagram = responseString["instagram"] as? String {
                        self.instagramName = instagram
                        print("insta name" + " " + self.instagramName)
                    }
                    else {
                        self.instagramButton.isUserInteractionEnabled = false;
                    }
                    if let snapchat = responseString["snapchat"] as? String {
                        self.snapchatName = snapchat
                        print("snapchat name" + " " + self.snapchatName)
                    }
                    else {
                        self.snapchatButton.isUserInteractionEnabled = false;
                    }
                    if let facebook = responseString["facebook"] as? String {
                        self.facebookURL = facebook
                        print("facebook URL" + " " + self.facebookURL)
                    }
                    else {
                        self.facebookButton.isUserInteractionEnabled = false;
                    }
                    
                    if let email = responseString["email"] as? String {
                        self.emailString = email
                        print("email" + " " + self.emailString)
                    }
                    
                    else {
                        self.email.text = "No email"

                    }
                   
                    if let phoneNumber = responseString["phone"] as? Int {
                        self.phoneNumberInt = phoneNumber
                        print("phone number" + " " + "\(self.phoneNumberInt)")
                    }
                    
                    else {
                        self.phoneNumber.text = "No phone number"
                    }
                    
                    if let name = responseString["name"] as? String {
                        self.nameString = name
                        print("name" + " " + self.nameString)
                    }
                        
                    else {
                        self.phoneNumber.text = "No phone number"
                    }
                    
                    if let linkedin = responseString["linkedin"] as? String {
                        self.linkedinURL = linkedin
                        print("linked in" + " " + self.linkedinURL)
                    }
                    
                    else {
                        self.linkedinButton.isUserInteractionEnabled = false;
                    }
                    
                    if let youtube = responseString["youtube"] as? String {
                        self.youtubeURL = youtube
                        print("youtube" + " " + self.youtubeURL)
                    }
                        
                    else {
                        self.youtubeButton.isUserInteractionEnabled = false;
                    }
                    
                    DispatchQueue.main.sync {
                            self.phoneNumber.text = "\(self.phoneNumberInt)"
                            self.email.text = self.emailString
                            self.name.text = self.nameString
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
    
    @IBAction func connectLinkedin(_ sender: AnyObject) {
        if let url = URL(string: self.linkedinURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("Open \(self.linkedinURL): \(success)")
                    UIApplication.shared.openURL(url as URL)
                    
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func subscribeYouTube(_ sender: AnyObject) {
        if let url = URL(string: self.youtubeURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("Open \(self.youtubeURL): \(success)")
                    UIApplication.shared.openURL(url as URL)
                    
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func homeButtonDidPress(_ sender: AnyObject) {
        
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is MainMenuVC {
                    navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
    }
    
    
    @IBAction func backButtonDidPress(_ sender: AnyObject) {
        navigationController?.popViewController(animated:true)
    }
}
