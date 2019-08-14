//
//  Pay.swift
//  PinOnGlass
//
//  Created by user914766 on 8/7/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import UIKit

class Pay: NSObject {
    
    var terminalSerialNumber: String = ""
    var tid: String = ""
    var amount: Double = 0.0
    var productCode: Int = 0
    var fallbackScenario: String = "1"
    var sequenceNumber: String  = ""
    var cardData: String = "";
 
    
    // Validate required information
    func setData(amount: Double, seqNumber: String, emv: String,  tsn: String, tid: String,pcode: Int, fbScenario: String) -> Bool {
        
        if(amount < 0.01) {
            return false;
        }
        
        // assigning data
        terminalSerialNumber = tsn;
        self.tid = tid;
        self.amount = amount;
        productCode =  pcode;
        fallbackScenario = fbScenario;
        sequenceNumber = seqNumber;
        cardData = emv;
        
        
        return true;
    }
    
    
    

}
