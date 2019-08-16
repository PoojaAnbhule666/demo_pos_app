//
//  DeviceManager.swift
//  PinOnGlass
//
//  Created by user914766 on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import Foundation
import IDTech


extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}

class DeviceManager: NSObject, IDT_NEO2_Delegate {
    
    // getting refernce to pinonglass oject
    public var PinOnGlass: PinOnGlass?
    public var Request: Any?
    private var EMVData: IDTEMVData?
    private var encryptTags: [AnyHashable: Any]?
    
    public var _deviceConnected : Int = 0

    
    @objc func iccStatus() {

        
        var response: UnsafeMutablePointer<ICCReaderStatus>? = nil
        let rt: RETURN_CODE = IDT_NEO2.sharedController().icc_get(&response)
        
        if RETURN_CODE_DO_SUCCESS != rt {
            print("ERROR!!! Get ICC status")
            return
        }
        
        var sta: String
        
        if (response?.pointee.iccPower)! {
            sta = "[ICC powered]"
        } else {
            sta = "[ICC power not ready]"
        }
        
        if (response?.pointee.cardSeated)! {
            sta = "\(sta), [Card seated]"
        } else {
            sta = "\(sta), [Card not seated]"
        }
        return;
    }
    
    func lcdDisplay(_ mode: Int32, lines: [Any]!) {
        print("LCD");
    }
    
    
    
    // Starting new trsnaction
    public func startTransation(dAmount: Double) {
        
        print(" -------- START TRANS ------------")
        
        let _Message: Message = Message()
//        _ = Timer(timeInterval: 0.4, target: self, selector: #selector(iccStatus), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(iccStatus), userInfo: nil, repeats: true)

        return ;
        

        
        // start new transaction
        // let data = Data(hexString: "DFEF370104")
        // let returnCode = IDT_NEO2.sharedController().device_startTransaction(1.00,  type: 0, timeout: 60, tags: nil)
        
        let returnCode = IDT_NEO2.sharedController().emv_startTransaction(dAmount, amtOther: 0, type: 0, timeout: 60, tags: nil, forceOnline: false, fallback: true)
        
        if RETURN_CODE_DO_SUCCESS == returnCode {
            PinOnGlass?._Delegate?.payMessage(message: _Message.Information(code: "M004"))
        } else {
            PinOnGlass?._Delegate?.payError(error: _Message.Error(code: "C018"), response: NSObject())
        }
        
        return
    }
    
    
    // Authroize trsnaction
    public func authroize() {
        IDT_NEO2.sharedController()?.emv_authenticateTransaction(nil)
        self.ServerComplete()
    }
    
    // cancel current transaction
    public func cancelTransaction() {
        IDT_NEO2.sharedController()?.emv_cancelTransaction()
        PinOnGlass?.cancelTransaction()

    }
    
    

    
    // complete transaction
    public func completeTransaction() {
        // Transaction completed successfully
        IDT_NEO2.sharedController()?.emv_completeOnlineEMVTransaction(true, hostResponseTags: nil)
        
        //@TODO: Send request recived from server
        PinOnGlass?.completeTranstion()

    }
    
    public func openPinEntry() {
        self.ServerAuthroize()
    }
    
    //Rest Api Call for getting card information
    public func ServerCardData() {
        // REST Api :// cardData
        if(true) {
            openPinEntry()
        } else {
            self.cancelTransaction()
        }
    }
    
    // REST API Call for authriozation
    public func ServerAuthroize() {
        //@TODO: REST API Authorize frm server ::: authorization ::::
        
        if(true) {
            self.authroize()
        } else {
            self.cancelTransaction()
        }
    }
    
    //REST Call for completetion of trsnaction
    public func ServerComplete() {
        
        //RESTT API Calll: ::completeTrans::
        if(true) {
            self.completeTransaction()
        } else {
            self.cancelTransaction()
        }
        
    }
    
    
    // delegated function
    func emvTransactionData(_ emvData: IDTEMVData!, errorCode error: Int32) {
        
        let _Message: Message = Message()
        // Setting emv data for later reference
        self.EMVData = emvData
        
        if emvData == nil {
            PinOnGlass?.sendError(Code: "C002")
            return
        }
        
        if emvData.resultCodeV2 == EMV_RESULT_CODE_V2_TIME_OUT {
            PinOnGlass?.sendError(Code: "C008")
            return
        }
        
        if emvData.resultCodeV2 != EMV_RESULT_CODE_V2_NO_RESPONSE {
            PinOnGlass?.sendError(Code: "C009")
            return
        }
        
        if emvData.resultCodeV2 == EMV_RESULT_CODE_V2_GO_ONLINE {

        }
        
        if emvData.resultCodeV2 == EMV_RESULT_CODE_V2_START_TRANS_SUCCESS {
            //Offline trsnaction success
            self.ServerAuthroize()
        }
        
        if emvData.resultCodeV2 == EMV_RESULT_CODE_V2_APPROVED || emvData.resultCodeV2 == EMV_RESULT_CODE_V2_APPROVED_OFFLINE {
            self.ServerAuthroize()
        }
        
        
        if emvData.cardType == 0 {
           
        }
        
        if emvData.cardType == 1 {
            PinOnGlass?._Delegate?.payMessage(message: _Message.Information(code: "M005"))
        }
        
       
        if emvData.encryptedTags != nil {
            self.encryptTags = emvData.encryptedTags
            //self.ServerAuthroize()
        }
    
    }
    
    // called when pin is requested
    func pinRequest(_ mode: EMV_PIN_MODE_Types, key: Data!, pan PAN: Data!, startTO: Int32, intervalTO: Int32, language: String!) {
        
        //offline request
        if(mode == EMV_PIN_MODE_OFFLINE_PIN) {
            self.ServerCardData() 
        }
    }
    
    
    
    
    // Disconnect bluetooth
    func disconnect() -> Bool{
        print("Disconnected")
        return true
    }
    
    
    // =============== CALLBACK ====================== //
    func deviceMessage(_ message: String!) {
        print(message ?? "");
    }
    
    
    @objc func getDeviceUUID() {
        //print(IDT_NEO2.sharedController()?.device_connectedBLEDevice() ?? "");
    }
    func deviceConnected() {
        
        //Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getDeviceUUID), userInfo: nil, repeats: true);
        
        //let terminalManager: TerminalDataManager = TerminalDataManager()
        //terminalManager.setUpTerminal()
        self._deviceConnected = 1;
        let message :Message = Message()
        self.PinOnGlass?._Delegate?.payMessage(message: message.Information(code: "M006"))
        //self.PinOnGlass?.startPayment()
    }
    
    func deviceDisconnected() {
        if(self._deviceConnected == 1) {
            let _Message = Message()
            self.PinOnGlass?._Delegate?.payError(error: _Message.Error(code: "B005"), response: NSObject())
        }
    }

}
