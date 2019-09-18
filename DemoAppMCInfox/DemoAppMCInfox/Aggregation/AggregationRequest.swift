//
//  AggregationRequest.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 17/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import Foundation

class AggregationList: NSObject {
    
var tid: String = ""
var fromDate: String = "" //YYYY-MM-DD HH:II
var toDate: String = ""
var fromTid: String  = ""
var toTid: String = ""


// Validate required information
func setData(tid: String, uuid: String, fromDate: String,  toDate: String, fromTid: String, toTid: String){
    
    // assigning data
    self.tid = tid
    self.fromDate = fromDate
    self.toDate = toDate
    self.fromTid = fromTid
    self.toTid = toTid
}

//func getData() -> NSDictionary {
//    let dict : NSMutableDictionary = [:]
//
//    dict["tid"] = tid
//
//    dict["FromDate"] = fromDate
//    dict["ToDate"] = toDate
//    dict["FromTID"] = fromTid
//    dict["ToTID"] = toTid
//
//    return dict
//}
    
    func getData() -> [String : Any] {
        var dict : [String : Any] = [:]

        dict["tid"] = tid
        dict["FromDate"] = fromDate
        dict["ToDate"] = toDate
        dict["FromTID"] = fromTid
        dict["ToTID"] = toTid
        
        return dict
    }


}
