//
//  ViewController.swift
//  POSCart
//
//  Created by user914766 on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import UIKit
import PinOnGlass


class ViewController: UIViewController, PinOnGlass_Delegate {

    @IBOutlet weak var PayButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
     var CafisFramework: PinOnGlass?
    
    // button click
    @IBAction func payButtonClick(_ sender: Any) {
        print("Transaction  Started")
        self.CafisFramework?.startTransaction(dAmount: 10.00, sSeqNumber: "ttt", sProductCategoryCode: "000",sDeviceName: "");
    }
    
    
    //cancel button
    @IBAction func cancelButtonClick(_ sender: Any) {
        print("Transaction  Cancelled")
        self.CafisFramework?.cancel();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.CafisFramework = PinOnGlass(Delegate: self); 
        self.CafisFramework?._Delegate = self;
    }
    
    func payMessage(message: MessageData) {
        print("Message");
    }
    
    func payError(error: MessageData, response: NSObject) {
        print("Got Error");
    }
    
    func paySuccess(response: NSObject) {
        print("Message");
    }


}
