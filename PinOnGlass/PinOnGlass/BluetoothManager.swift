//
//  BluetoothManager.swift
//  PinOnGlass
//
//  Created by user914766 on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import Foundation
import IDTech

class BluetoothManager: NSObject, IDT_NEO2_Delegate , CBCentralManagerDelegate  {
    
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
            self.bluetoothStatus = true
            break
        case .poweredOff:
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
        print(batteryLevel)
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
        
            IDT_NEO2.sharedController().device_setBLEFriendlyName(deviceName)
            if(IDT_NEO2.sharedController().device_enableBLEDeviceSearch(nil) == false) {
                print("Bluetooth not connected")
                return false 
            }
        } else {
            self.PinOnGlass?.startPayment()
        }
        
        return true
    }
    
    
}
