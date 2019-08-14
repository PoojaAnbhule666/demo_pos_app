//
//  Property.swift
//  PinOnGlass
//
//  Created by user914766 on 8/5/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//


import Foundation


struct Settings {
    
    // URL to api server, pointing only to base url
    static let API_VERIFY : String = "www.kumar.ws"
    
    // URL to api server, pointing only to base url
    static let API_SERVER : String = "http://localhost:9100/"
    
    // URL to create secure channel
    static let URL_ROCK : String = "createLink"
    
    // URL to send card data to get moe information about card
    static let URL_TERMINALAUTH : String = "terminalActivation"
    
    // URL to send card data to get moe information about card
    static let URL_ANALYSIS : String = "cardData"
    
    // URL To authroize trsnaction
    static let URL_AUTHORIZE : String = "authroizeTrans"
    
    // URL TO complete tsrnaction
    static let URL_COMPLETE :String = "completeTrans"
    
    static let DEFAULT_LANG:String = "JP"
    static let DEFAULT_CURRENCY = "JPY"
}
