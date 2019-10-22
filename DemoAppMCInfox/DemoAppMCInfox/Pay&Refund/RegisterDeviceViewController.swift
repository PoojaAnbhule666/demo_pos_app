//
//  RegisterDeviceViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/23/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

@available(iOS 11.0, *)
class RegisterDeviceViewController: UIViewController , PinOnGlass_Delegate {

    @IBOutlet weak var statusLabel: UILabel!
     var payment : PinOnGlass = PinOnGlass()
     let greenColor = UIColor(named: "ColorSucces")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "---"
        startTransactionProcess()
        
        // Do any additional setup after loading the view.
    }
    
    
    func startTransactionProcess() {

        payment = PinOnGlass.shared(Delegate: self)
        payment.registerNewDevice(deviceName: "")   //IDTECH3187
        
        
    }
    
    
    
    func paySuccess(response: NSDictionary) {
        print("response is ..." , response)
        if(response["resultCode"] as? String == "0")
        {
            statusLabel.text = "Device registered successfully"
            statusLabel.textColor =  greenColor //UIColor (red: 40.0/255.0, green: 128.0/255.0, blue: 95/255.0, alpha: 1.0)
        }
        else {
            statusLabel.text = "Device not registered"
            statusLabel.textColor = .red
        }
        
        
        
    }
    
    func payError(error: MessageData, response: NSObject) {
        print("----------ERROR ------------- ", error.Code)
        statusLabel.text = error.Message
        statusLabel.textColor = .red
    }
    
    
    func payMessage(message: MessageData) {
        print("----------MESSAGE -------------",message.Code)
    }
    
}
