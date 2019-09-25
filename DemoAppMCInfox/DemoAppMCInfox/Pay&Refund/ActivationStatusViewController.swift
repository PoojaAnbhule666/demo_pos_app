//
//  ActivationStatusControllerViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/19/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

@available(iOS 11.0, *)
class ActivationStatusViewController: UIViewController , PinOnGlass_Delegate {
    @IBOutlet weak var statusLabel: UILabel!
    let greenColor = UIColor(named: "ColorSucces")
    
    
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
            statusLabel.textColor = greenColor
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
