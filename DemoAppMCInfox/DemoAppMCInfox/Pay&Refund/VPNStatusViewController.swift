//
//  VPNStatusViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 10/15/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class VPNStatusViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getVPNStatus()

        // Do any additional setup after loading the view.
    }
    
    
    
     // MARK: - ApiCall
    
    func getVPNStatus() {
         AppCommonData.sharedInstance.addLoader()
         let url = String(format: "https://app.dev.cafis-magic.com/vpn/connectToVPN")
         AppCommonData.sharedInstance.callGETservice(serviceURL: url) { (isSuccesfull, statusCode , response) in
                    
                if isSuccesfull {
                        
                   print("response of getVPNStatus is ", response ?? "nil")
                   let responseStr = response as! String
                   let data = Data(responseStr.utf8)
                   do {

                        let vpnData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let dataDic = vpnData! as Dictionary
                       print("vpn dic is ",dataDic)
                        let keys = dataDic.keys
                        for key in keys {
                           if (key == "vPNConnectionStatus"){
                            if(dataDic["vPNConnectionStatus"] as! Bool)  {
                                
                                self.setMessage(message: "Connected")

                            }
                            else {
                                self.setMessage(message: "Not Connected")
                            }
                           }
                        }
                   } catch _ {
                       self.setMessage(message: "Not able to get the status")
                   }
               }
               else {
                    //print("server error")
                   self.setMessage(message: "Server error")
               }
         }
    }
    
    
    
    func setMessage(message : String) {
        AppCommonData.sharedInstance.removeLoader()
        DispatchQueue.main.async{
             self.statusLabel.text = message
            if(message == "Connected") {
                self.statusLabel.textColor = .green
            }else {
                self.statusLabel.textColor = .red
            }
        }
    }
   
}
