//
//  AggregateCallAPI.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/19/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class AggregateCallAPI: NSObject {

    private var sharedSession: URLSession!
    static let sharedInstance = AggregateCallAPI()
    
    
    override init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpAdditionalHeaders = ["Cache-Control" : "no-cache"]
        self.sharedSession = URLSession(configuration: config)
    }
    
    
    public func checkSession(urlsession: URLSession){
        self.sharedSession = urlsession
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
            return AggregateCallAPI.getStringFromData(data: jsonData)
        } catch {
            return nil
        }
    }
    
    
    func callPostService(serviceUrl : String, parameters:Any, completionBlock : @escaping (_ successful:Bool, _ statusCode:Int, _ response:Any?) -> ()) {
        guard let url = URL(string: "\(serviceUrl)")
            else {
                DispatchQueue.main.async
                    {
                        completionBlock(false, 000 ,"Invalid URL") // 000 - status code set for invalid url
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
                
                let httpResponse = response as? HTTPURLResponse
                if error == nil {
                    DispatchQueue.main.async {
                        
                        print("\(#function) :  Success \n \(AggregateCallAPI.getStringFromData(data: data!) ?? "")")
                        completionBlock(true, httpResponse!.statusCode,(AggregateCallAPI.getStringFromData(data: data!)))
                    }
                } else {
                    print("\(#function) error : \(error?.localizedDescription ?? "No error")")
                    
                    DispatchQueue.main.async {
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            if((400...499).contains(httpResponse.statusCode) ) {
                                
                                completionBlock(false,httpResponse.statusCode, "40X error")
                            }
                            else if((500...599).contains(httpResponse.statusCode)){
                                completionBlock(false,httpResponse.statusCode, " 50X Error")
                            }
                        }
                        else {
                            completionBlock(false,0000, "Request TimeOut")
                        }
                        
                        
                    }
                }
            }
            dataTask.resume()
        } catch let error {
            print("\(#function) error : \(error.localizedDescription)")
            DispatchQueue.main.async {
                completionBlock(false,001, "Connection Error")
            }
        }
    }
}
