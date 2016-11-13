//
//  MainMenuVC.swift
//  QRCodeReader.swift
//
//  Created by Tim Gorer on 11/12/16.
//  Copyright © 2016 Yannick Loriot. All rights reserved.
//

import Foundation
import UIKit

class MainMenuVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if "openScan" == segue.identifier {
            if let destinationVC = segue.destination as? ScanShareViewController {
                destinationVC.openScanner = true
            }
        }
        
        else if "openShare" == segue.identifier {
            // don't open scanner
        }
    }
}
