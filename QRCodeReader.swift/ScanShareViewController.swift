/*
 * QRCodeReader.swift
 *
 * Copyright 2014-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and tvar permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit
import AVFoundation




class ScanShareViewController: UIViewController, QRCodeReaderViewControllerDelegate {
  
    var id = "5"
    var website = "https://asapserver.herokuapp.com/api/web/";
    var message = ""
    var openScanner = false;
    
    @IBOutlet weak var imageViewLarge: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // large
        // default
        imageViewLarge.image = {
            var qrCode = QRCode(website+id)! // hard coded QR code
            qrCode.size = self.imageViewLarge.bounds.size
            qrCode.errorCorrection = .High
            return qrCode.image
        }()
        
        // open scanner if user pressed scan button in MainMenuVC
        if self.openScanner == true {
            self.scanAction(self)
        }
        
    }

  lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
    $0.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
    $0.showTorchButton = true
  })

  @IBAction func scanAction(_ sender: AnyObject) {
    if QRCodeReader.supportsMetadataObjectTypes() {
      reader.modalPresentationStyle = .formSheet
      reader.delegate               = self

      reader.completionBlock = { (result: QRCodeReaderResult?) in
        if let result = result {
          print("Completion with result: \(result.value) of type \(result.metadataType)")
        }
      }

      present(reader, animated: true, completion: nil)
    }
    else {
      let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

      present(alert, animated: true, completion: nil)
    }
  }

  // MARK: - QRCodeReader Delegate Methods

  func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
    reader.stopScanning()
 
    dismiss(animated: true) { [weak self] in
        self?.message = String (format: result.value);
        
        if !(self?.message.hasPrefix("https://asapserver.herokuapp.com/api/web/"))! {
            let alert = UIAlertController(
                title: "Invalid QR Code!",
                message: "Invalid QR code read. Please try again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self?.present(alert, animated: true, completion: nil)
            
            }
        else{
            self?.message = (self?.message.replacingOccurrences(of: "web", with: "social", options: .literal, range: nil))! // replace web with social
            self?.performSegue(withIdentifier: "openProfile", sender: self) // open other user's profile on scan if everything is ok
            let ind = self?.message.index((self?.message.startIndex)!, offsetBy: 35);
            self?.id = (self?.message.substring(from: ind!))!

        }
    }
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if "openProfile" == segue.identifier {
            if let destinationVC = segue.destination as? UserProfileViewController {
                destinationVC.url = NSURL(string: self.message)
            }
        
        }
  }
  
  func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
    if let cameraName = newCaptureDevice.device.localizedName {
      print("Switching capturing to: \(cameraName)")
    }
  }
  
  func readerDidCancel(_ reader: QRCodeReaderViewController) {
    reader.stopScanning()

    dismiss(animated: true, completion: nil)
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
