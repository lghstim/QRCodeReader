//
//  ContactsVC.swift
//  QRCodeReader.swift
//
//  Created by Tim Gorer on 11/12/16.
//  Copyright © 2016 Yannick Loriot. All rights reserved.
//

import Foundation
import UIKit


class ContactsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

}
