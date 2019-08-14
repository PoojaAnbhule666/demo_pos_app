//
//  PinOnGlass_Delegate.swift
//  PinOnGlass
//
//  Created by Lachhkeumar Nadar on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import UIKit
public protocol PinOnGlass_Delegate {
    
    /*
     * When transaction is successfull
    */
    func paySuccess(response: NSObject);
    
    /*
     * Called when error occur while processing transaction.
     *      - Server timeout
     *      - Device Error
     *      - Network error
     *      - Bluetooth error
    */
    func payError(error:MessageData, response: NSObject);
    
    /*
     * Information are send back to pos device
    */
    func payMessage(message: MessageData);
    
}
