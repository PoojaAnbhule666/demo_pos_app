//
//  NetworkManager.swift
//  PinOnGlass
//
//  Created by user914766 on 8/2/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import Foundation

class NetworkManager {
        
    // getting refernce to pinonglass oject
    public var PinOnGlass: PinOnGlass?
    private var Reach: ReachabilityManager = ReachabilityManager.shared
    

    func start(){
        Reach.delegate  = self
        Reach.startMonitoring()
    }
    
    // return status to delegated function
    func getStatus(Status: String) {
        if(Status == "") {
            let response = NSObject()
            let error = Message()
            
            PinOnGlass?._Delegate?.payError(error: error.Error(code: "N001"), response: response)
        } else {
            let response = NSObject()
            let error = Message()
            

            if(!checkInternet()) {
                PinOnGlass?._Delegate?.payError(error: error.Error(code: "N002"), response: response)
            }
            

            if(!checkCafisServer()) {
                PinOnGlass?._Delegate?.payError(error: error.Error(code: "N003"), response: response)
            }
        }
    }
    
    // Stop monitoring teh network status
    func stop(){
        Reach.stopMonitoring()
    }

    
    // Check connectivity to network
    func checkActive() -> Bool {
        // TRUE : if connected to network
        return (Reachability()!.isReachableViaWiFi || Reachability()!.isReachable) 
    }
    
    // check internet connectivity
    func checkInternet() -> Bool {
        return (Reachability.init(hostname: "www.google.com")!.isReachable)
    }
    
    
    func checkCafisServer() -> Bool {
        return ( Reachability.init(hostname: Settings.API_VERIFY)!.isReachable)
    }
    
    // call to create rock function
    func createRock() {
        
    }
    
    // authroie function
    func authroizeTransaction() {
        
    }
    
    // Complete transaction
    func completeTransaction() {
        
    }
    
    



}
