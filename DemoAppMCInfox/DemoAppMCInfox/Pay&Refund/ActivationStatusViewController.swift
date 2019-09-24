//
//  ActivationStatusControllerViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/19/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

class ActivationStatusViewController: UIViewController , PinOnGlass_Delegate {
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTransactionProcess()

        // Do any additional setup after loading the view.
    }
    

    func startTransactionProcess() {
        
        
       PinOnGlass.getShared()._Delegate = self
       PinOnGlass.getShared().getActivationStatus()
        
    }
    
    
    
    func paySuccess(response: NSDictionary) {
        // logTextView.text = "Transaction Complete"
        print("response is ..." , response)
        if(response["activationStatus"] as? String == "1")
        {
            statusLabel.text = "Inactive"
            statusLabel.textColor = .red
        }
        else {
            statusLabel.text = "Active"
            statusLabel.textColor = UIColor (red: 40.0/255.0, green: 128.0/255.0, blue: 95/255.0, alpha: 1.0)
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
