//
//  Message.swift
//  PinOnGlass
//
//  Created by user914766 on 8/5/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import UIKit

// Hold all messages
struct MessageCodes {
    
    // defined all errors
    static let Error = [
        "BOO1": "Bluetooth device is not enabled",
        "BOO2": "Friendly device name not provided",
        "B003": "Unable to locate device",
        "B004": "Unable to pair device",
        "B005": "Connection lost to device",
        "B006": "Low battery",
        "B007": "Bluetooth disabled",
        "N001": "Disconneted from network",
        "N002": "Internet not avaliable",
        "N003": "Unable to connct cafis server",
        "N004": "Offline - Connection dropped",
        "N005": "Offline - Connected but internet not avaliable",
        "S001": "Cannot secure enviroment",
        "S002": "Secure server not responding",
        "S003": "Unable to secure link",
        "S004": "Invalid Rock ID provided",
        "T001": "Invalid input",
        "T002": "Low terminal battery",
        "C001":"Reader not ready",
        "C002":"Unable to read card",
        "C003":"Invalid card",
        "C004":"Card blocked",
        "C005":"Card expired",
        "C006":"Card corrupted",
        "C007":"Exceed card limit",
        "C008":"Reading Timeout",
        "C009":"Not responding",
        "C010":"Card removed during transaction",
        "C011":"Unable to open pin entry screen",
        "C012":"Pin communication error",
        "C013":"Pin entry timeout",
        "C014":"Authroization error",
        "C015":"Communication to server error ",
        "C016":"Authorization communication error",
        "C017":"Cannot cancel transaction",
        "C018":"Unable to start transaction"
    ]
    
    // Success message code
    static let Success = [
        "S001" : "Transaction was successful"
    ]
    
    
    // general information message code
    static let Messages = [
        "M001": "Infromation recived form transaction",
        "M002": "Transaction initialize",
        "M003": "Insert Card",
        "M004": "Start Trasnaction",
        "M005": "Currently no support contact less card",
        "M006": "Bluetooth connected",
        "M007": "Device Bluetooth enabled",
    ]
    
}

public class MessageData: NSObject {
    public var Code: String = "";
    public  var Message: String = "";
    
    override init() {
        // blank
    }

}


// Class load messages
class Message: NSObject {
    
    override init() {
    }
    
    // create error code
    func Error(code: String)  -> MessageData {
        
        let message: MessageData = MessageData();
        if(MessageCodes.Error[code] != nil) {
            message.Code = code;
            message.Message = MessageCodes.Error[code]!;
        }
        
        return  message;
    }

    // create sucess
    func Success(code: String)  -> MessageData {
        
        let message: MessageData = MessageData();
        if(MessageCodes.Success[code] != nil) {
            message.Code = code;
            message.Message = MessageCodes.Success[code]!;
        }
        
        return  message;
    }
    
    
    // create sucess
    func Information(code: String)  -> MessageData {
        
        let message: MessageData = MessageData();
        if(MessageCodes.Messages[code] != nil) {
            message.Code = code;
            message.Message = MessageCodes.Messages[code]!;
        }
        
        return  message;
    }
    
}
