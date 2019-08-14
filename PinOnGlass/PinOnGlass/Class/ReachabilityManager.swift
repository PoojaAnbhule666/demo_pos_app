//
//  ReachabilityManager.swift
//  PinOnGlass
//
//  Created by user914766 on 8/6/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import UIKit


class ReachabilityManager: NSObject {
    
    // deletation send message
    var delegate:NetworkManager?;

    // Singleton instance of shared manager
    static let shared = ReachabilityManager()
    
    // Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    // Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    let reachability = Reachability()!
    
    override init() {
        // blank  init
    }
    
    
    // called once the network status is changed
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        
        switch reachability.currentReachabilityStatus {
            case .notReachable:
                self.delegate?.getStatus(Status: "")
            case .reachableViaWiFi:
                self.delegate?.getStatus(Status: "Wifi")
            case .reachableViaWWAN:
                self.delegate?.getStatus(Status: "WAN")
            
        }
    }
    
    
    // start montoring
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    
    
}
