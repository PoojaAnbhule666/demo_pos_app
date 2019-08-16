//
//  PinOnGlass.swift
//  PinOnGlass
//
//  Created by user914766 on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//
//  cancel()
//  startTransaction()
//  initCheck()
//  completeTransaction()
//  cancelTransaction()

import Foundation
import IDTech


open class PinOnGlass : NSObject, UIAlertViewDelegate{
    
    // added delegate varaiable
    public var _Delegate : PinOnGlass_Delegate?
    
    public var language: String = Settings.DEFAULT_LANG
    public var currency: String = Settings.DEFAULT_CURRENCY
    public var idTechDeviceName : String = ""
    
    private var transactionStarted: Int = 0
    
    private var dAmount:Double = 0
    private var sSeqNumber:String = ""
    private var sProductCategoryCode: String = ""
    

    // DECLARE: Private variable
    // Hold bluetooth class objects
    private var _Bluetooth: BluetoothManager
    
    // Holds Network  connectivity related function
    // also respobsile for doing rest calls
    private var _Network: NetworkManager
 
    // Funcationalty for Managing all IDTEch device action
    private var _Device: DeviceManager
    
    // Initialize PinOnGlass
    public init(Delegate: PinOnGlass_Delegate) {
        
      
        // Assign delegate deletegate class
        self._Delegate = Delegate
        self._Bluetooth = BluetoothManager()
        self._Network = NetworkManager()
        self._Device = DeviceManager()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
       super.init()
        
    }
    
    
    func activeTransaction() -> Int {
        return self.transactionStarted
    }
    
    func getNetwork() -> NetworkManager {
        return self._Network
    }
    
    
    func getDevice() -> DeviceManager {
        return self._Device;
    }
    // Send error response
    func sendError(Code: String, Response: NSObject? = nil) {
        let _Message: Message = Message()
        let _Response: NSObject = NSObject()
        
        if(Response != nil) {
            //_Response = Response
        }
        
        self._Delegate?.payError(error: _Message.Error(code: Code), response: _Response)
        self.cancelTransaction()
    }
    
    
    
    /**
     * start new transaction
     * dAmount : Amount to be charged
     * sSeqNumber : Order or Seqence Number
     * sProductCategoryCode: Category code provide by cafis
     * sDeviceName : IDTech device name if not provide it will prompt
     * sDevicePassword: IDTech Device Password
     * sLang : Language
     * sCurrencyCode: Currency code
     * sScrambledKeyPad : Scrambled keypad 
     */
 
    public func startTransaction(dAmount: Double,
            sSeqNumber: String,
            sProductCategoryCode: String,
            sDeviceName: String = "",
            sDevicePassword: String = "",
            sLang: String = "",
            sCurrencyCode: String = "", sScrambledKeyPad: Bool = false) {
        


        idTechDeviceName = sDeviceName
        
        print("ssDeviceName \(idTechDeviceName)")

        // Assign PinOnGlass refrence to active class
        IDT_NEO2.sharedController()?.delegate = self._Device
        self._Bluetooth.PinOnGlass = self
        self._Network.PinOnGlass = self
        self._Device.PinOnGlass = self
        
        if(_Bluetooth.checkActive() == false) {
            
            let message = Message()
            self._Delegate?.payError(error: message.Error(code: "B007"), response: NSObject());

            print("-- Bluetooth is not enabled ---")
            return 
        }
        
        
        let friendlyName : String = IDT_NEO2.sharedController().device_getBLEFriendlyName() ?? ""
        
        if(friendlyName != "IDTECH") {
            idTechDeviceName = friendlyName;
        }
        // initialize the default value
        if(sLang != "") { language = sLang }
        if(sCurrencyCode != "") { currency = sCurrencyCode }
        

        if(idTechDeviceName == "") {
            idTechDeviceName = self.showAlertWithTextField()
        }
        
        
        if(idTechDeviceName != "") {
            self._connect();
        }
        
        
    }
    
    func _connect() {
        if(initCheck() == false) {
            print("Error detected. in bluetooth")
        }
        
        //  starting network verification process
        _Network.start()
        _Bluetooth.start()
        
        if(self._Bluetooth.connect(deviceName: self.idTechDeviceName) == false) {
            let _Message : Message = Message();
            self._Delegate?.payError(error: _Message.Error(code: "BOO2"), response: NSObject())
            
        }
    }
    
    
    func showAlertWithTextField() -> String {
        var deviceNameText = ""
        
        let topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindow.Level.alert + 1
        
        let alertController = UIAlertController(title: "Device Request", message: "please enter the device name", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
                deviceNameText = text
                if(deviceNameText == "") {
                    let _Message : Message = Message();
                    self._Delegate?.payError(error: _Message.Error(code: "BOO2"), response: NSObject())
                }  else {
                    self.idTechDeviceName = deviceNameText
                    self._connect();
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            let _Message : Message = Message();
            self._Delegate?.payError(error: _Message.Error(code: "BOO2"), response: NSObject())
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Device name"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        //            self.present(alertController, animated: true, completion: nil)
        topWindow?.makeKeyAndVisible()
//        topWindow?.backgroundColor = UIColor.white
        topWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        return deviceNameText
    }
    
    func startPayment() {
        self._Device.startTransation(dAmount: self.dAmount)
        self.transactionStarted = 1
    }
    
    
    // Call function to cancel transaction mannually.
    // Transaction cannot be cancelled after trans is complete
    public func cancel() {
        //@TODO:
        self.cancelTransaction()
    }
    
    // init check of system
    func initCheck() -> Bool {
        
        var returnStatus:Bool = true
        // check for bluetooth connection
        if(_Bluetooth.checkActive() == false) {
            print("-- Bluetooth not connected ---")
            returnStatus  = false
        }
  
        if(_Network.checkActive() == false) {
            print("network not connected")
            returnStatus  = false
        }
        
        if(_Network.checkInternet() == false) {
            print("Internet not avaliable")
            returnStatus  = false
        }
        
        //if(_Network.checkCafisServer() == false) {
        //
        //}
        return returnStatus
    }
    
    // Call if transaction need to be canncelled for any reason
    func cancelTransaction() {
        //@TODO:
        let _Message: Message = Message()
        self._Delegate?.payError(error: _Message.Error(code: "C001"), response: NSObject())

        // stop network notification listener
        _Network.stop()
        _Bluetooth.stop()
    }
    
    // Call if transaction is successfully completed at server
    func completeTranstion() {
        //@TODO:
        
        self._Delegate?.paySuccess(response: NSObject())
        // stop network notification listener
         _Network.stop()
        _Bluetooth.stop() 
    }
    


}
