//
//  BluetoothManager.swift
//  PinOnGlass
//
//  Created by user914766 on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import Foundation
import IDTech

class BluetoothManager: NSObject

, CBCentralManagerDelegate  {
    
    // getting refernce to pinonglass oject
    public var PinOnGlass: PinOnGlass?
    public var _Battery: Battery?
    public var manager:CBCentralManager!
    
    public var batteryLevel: Float = 1
    private var bluetoothStatus : Bool = false
    
    override init() {
        super.init()
        UIDevice.current.isBatteryMonitoringEnabled = true
        // Bluetooth manager
        manager = CBCentralManager(delegate: self, queue: nil)
        _Battery = Battery()
    }
    
  // CBCentral delegate function
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            let message = Message()
            self.PinOnGlass?._Delegate?.payMessage(message: message.Information(code: "M007"))
            self.bluetoothStatus = true
            
            
            if(self.PinOnGlass?.idTechDeviceName == "") {
                self.PinOnGlass?.idTechDeviceName = self.PinOnGlass?.showAlertWithTextField() ?? ""
            }
            break
        case .poweredOff:
            let message = Message()
            self.PinOnGlass?._Delegate?.payError(error: message.Error(code: "B007"), response: NSObject());
            self.bluetoothStatus = false
            break
            
        case .resetting:
            print("restting")
            break
        case .unauthorized:
            print("un auth")
            break
        case .unsupported:
            print("un supported")
            break
        case .unknown:
            print("unknownp")
            break
        default:
            self.bluetoothStatus = false
            break
        }
        
        if(self.bluetoothStatus == false) {
            let message  = Message()
            self.PinOnGlass?._Delegate?.payError(error: message.Error(code: "B001"), response: NSObject())
        }
    }
    
    // start the noficiation center for battery / Bluetooth
    func start() {
        _Battery?.delegate = self
        _Battery?.start()
    }
    
    // stop notification center for battery & bluetooth
    func stop() {
        _Battery?.stop()
    }
    
    func  deviceBattery(level: Float){
        // display battery
        self.batteryLevel = level
    }
    
    func checkBattery() -> Bool {
        self.batteryLevel = UIDevice.current.batteryLevel
        return true
    }
    
    // Check if bluetooth
    func checkActive() -> Bool{
        
        return self.bluetoothStatus
    }
    
    
    
    // connect to bluetooth device for device username and password
    func connect(deviceName: String, devicePassword: String = "") -> Bool{
        
        let friendlyName : String = IDT_NEO2.sharedController().device_getBLEFriendlyName() ?? ""
        if(friendlyName == "IDTECH") {
            if(deviceName == "") {
                let _Message : Message = Message();
                self.PinOnGlass?._Delegate?.payError(error: _Message.Error(code: "B004"), response: NSObject())
                return false;
            }
            IDT_NEO2.sharedController().device_setBLEFriendlyName(deviceName);
        }
        
        if(IDT_NEO2.sharedController().device_enableBLEDeviceSearch(nil) == false) {
            let _Message1 : Message = Message();
            self.PinOnGlass?._Delegate?.payError(error: _Message1.Error(code: "B003"), response: NSObject())
            return false;
        }
        
        
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(checkBlueToothConnection), userInfo: nil, repeats: false)
        
        return true
    }
    
    @objc func checkBlueToothConnection() {
        if self.PinOnGlass?.getDevice()._deviceConnected == 0 {
            let _Message1 : Message = Message();
            self.PinOnGlass?._Delegate?.payError(error: _Message1.Error(code: "B003"), response: NSObject())
            IDT_NEO2.sharedController()?.device_disconnectBLE();
            IDT_NEO2.sharedController()?.device_setBLEFriendlyName("IDTECH");
        }
    }
    
    
}
