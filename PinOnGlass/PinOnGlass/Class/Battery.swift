//
//  Battery.swift
//  PinOnGlass
//
//  Created by user914766 on 8/7/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//
// Check battery actvity

import UIKit

class Battery: NSObject {
    
    
    // Hold delegate of devicemanager
    var delegate: BluetoothManager?;
    

    override init() {
        // Enable battery montoring status
        UIDevice.current.isBatteryMonitoringEnabled = true;
        
    }
    
    //start observer
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
    }
    
    // stop observer
    func  stop() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.batteryLevelDidChangeNotification, object: nil);
        
    }
    
    ///////////////////////////////////////////////////////////////
    // Battery level changes status
    
    @objc func batteryLevelDidChange(_ notification: Notification) {
        delegate?.deviceBattery(level: UIDevice.current.batteryLevel);
    }
    
    


}
