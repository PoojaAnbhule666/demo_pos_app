//
//  AppCommonData.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 20/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
//@available(iOS 11.0, *)
class Apicall : NSObject {
    
    static let sharedInstance = Apicall()
    
    let loadingView : LodingViewController
    let currentStoryboard : UIStoryboard
    
    private override init() {
        
        self.currentStoryboard = UIStoryboard(name: "Main",
                                              bundle: Bundle.main)
        
        self.loadingView = currentStoryboard.instantiateViewController(withIdentifier: "LodingViewController") as! LodingViewController
        
        super.init()
    }
    
    private var sharedSession: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpAdditionalHeaders = ["Cache-Control" : "no-cache"]
        return URLSession(configuration: config)
    }
    
    
    // MARK: Loader
    
    func addLoader() {
        print("loading.....")
        UIApplication.shared.keyWindow?.addSubview(self.loadingView.view)
    }
    
    func removeLoader() {
        self.loadingView.view.removeFromSuperview()
    }
    
    // MARK:- services methods
    
    class func getStringFromData(data: Data) -> String? {
        guard let str = String(data: data, encoding: .utf8) else { return nil }
        return str
    }
    class func getJSONObject(data: Data) -> Any? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data,
                                                              options: [])
            return jsonObject
        } catch {
            return nil
        }
    }
    
    class func getJSONStringFromObject(_ jsonObject: Any) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject,
                                                      options: .init(rawValue: 0))
            return Apicall.getStringFromData(data: jsonData)
        } catch {
            return nil
        }
    }
    
    func sendPOSTDataWithoutDataKey(serviceUrl : String, parameters:Any, completionBlock : @escaping (_ successful:Bool,_ response:Any?) -> ()) {
        
        guard let url = URL(string: "\(serviceUrl)")
            else {
                DispatchQueue.main.async
                    {
                        completionBlock(false, "Invalid URL")
                }
                return
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters,
                                                  options: [])
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let dataTask = sharedSession.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        
                        print("\(#function) :  Success \n \(Apicall.getStringFromData(data: data!) ?? "")")
                        //                        print("\(#function) : Success \n \(String(describing: Apicall.getStringFromData(data: data!)))")
                        //                        completionBlock(true,(Apicall.getJSONObject(data: data!)))
                        completionBlock(true,(Apicall.getStringFromData(data: data!)))
                    }
                } else {
                    print("\(#function) error : \(error?.localizedDescription ?? "No error")")
                    
                    DispatchQueue.main.async {
                        completionBlock(false, "Connection Error")
                    }
                }
            }
            dataTask.resume()
        } catch let error {
            print("\(#function) error : \(error.localizedDescription)")
            DispatchQueue.main.async {
                completionBlock(false, "Connection Error")
            }
        }
    }
    
    
}
