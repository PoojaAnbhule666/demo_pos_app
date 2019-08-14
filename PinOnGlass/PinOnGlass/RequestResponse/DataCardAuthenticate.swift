//
//  DataCardAuthenticate.swift
//  PinOnGlass
//
//  Created by user914766 on 8/7/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//
// Initialize object required by DataCardAuthenticate class

import UIKit

class DataCardAuthenticate: NSObject {
    
    var authCode: String = ""
    var cardData: String = ""
    
    override init() {
        // Nothing to override
    }
    
    
    // Set required parameter for DataCard Auth request
    func setData(Code: String, Card: String) -> Bool {
        
        if(Code == "" || Card == "") {
            return false;
        }
        authCode = Code;
        cardData = Card;
        
        return true;
    }
    
 
}
