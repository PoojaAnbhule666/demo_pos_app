//
//  RegisterDeviceViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/23/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

class RegisterDeviceViewController: UIViewController , PinOnGlass_Delegate {

    @IBOutlet weak var statusLabel: UILabel!
     var payment : PinOnGlass = PinOnGlass()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTransactionProcess()
        
        // Do any additional setup after loading the view.
    }
    
    
    func startTransactionProcess() {
        
       
        payment = PinOnGlass.shared(Delegate: self)
        payment.registerNewDevice(deviceName: "IDT23181")
        //PinOnGlass.getShared()._Delegate = self
        //PinOnGlass.getShared().registerNewDevice()
        
    }
    
    
    
    func paySuccess(response: NSDictionary) {
        // logTextView.text = "Transaction Complete"
        print("response is ..." , response)
        if(response["resultCode"] as? String == "0")
        {
            statusLabel.text = "Device registered successfully"
            statusLabel.textColor = UIColor (red: 40.0/255.0, green: 128.0/255.0, blue: 95/255.0, alpha: 1.0)
        }
        else {
            statusLabel.text = "Device not registered"
            statusLabel.textColor = .red
        }
        
        
        
    }
    
    func payError(error: MessageData, response: NSObject) {
        print("----------ERROR ------------- ", error.Code)
        statusLabel.text = error.Message
        
    }
    
    
    func payMessage(message: MessageData) {
        print("----------MESSAGE -------------",message.Code)
    }
    
}
