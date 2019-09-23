//
//  AggregationViewController.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 11/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit


@available(iOS 11.0, *)
class AggregationViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var topTabBar: UIView!
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var summaryTab_View: UIView!
    @IBOutlet weak var DetailTab_View: UIView!
    @IBOutlet weak var subView_summary: UIView!
    @IBOutlet weak var subView_Detail: UIView!
    @IBOutlet weak var tidFrom_textField: UITextField!
    @IBOutlet weak var tidTo_TextField: UITextField!
    @IBOutlet weak var dateFrom_TextField: UITextField!
    @IBOutlet weak var dateTo_TextField: UITextField!
    
    var numberToolbar:UIToolbar? = nil
    var currentTextField:UITextField? = nil
    var  isUpdatePageDisplayed : Bool = false
     var detailData = [DetailData]()
    var aggregateData_ = [AggregateData]()
    var aggregationRequest : AggregationRequest = AggregationRequest()
    
    let colorSucess = UIColor(named: "ColorSucces")

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.displayDatePicker(textfield: self.dateTo_TextField)
        self.displayDatePicker(textfield: self.dateFrom_TextField)
        
//         readJson()
//        testCallAGgregateApi()
        setCurrentdate()
        
        
        aggregateCall()
        
        
        loadController()
        
        numberToolbarForKeyBoard(textFiled: dateTo_TextField)
        numberToolbarForKeyBoard(textFiled: dateFrom_TextField)
        summaryTab_View .backgroundColor =  UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0)
        DetailTab_View .backgroundColor = .white
        summaryTab_View.layer.cornerRadius = 12
        DetailTab_View.layer.cornerRadius = 12
    }
    
    func loadController()  {
        let summaryVc = self.storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        self .addChild(summaryVc)
        summaryVc.view.frame = subView_summary.bounds
        summaryVc._aggregateData = aggregateData_
        subView_summary .addSubview(summaryVc.view)
        self .addChild(summaryVc)
        summaryVc .didMove(toParent: self)
        
        let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self .addChild(detailVc)
        detailVc.view.frame = subView_Detail.bounds
        detailVc.detailData_ = detailData
        print("deataildata1",detailData)
        subView_Detail .addSubview(detailVc.view)
        self .addChild(detailVc)
        
        detailVc .didMove(toParent: self)
    }
    
    
    func setCurrentdate()  {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH"
        let formattedDate = format.string(from: date)
        print("formattedDate---\(formattedDate)")
//        current_Date = formattedDate
//        filteredDate(date: current_Date)
        dateFrom_TextField.text = formattedDate
        
    }
    
    @IBAction func tap_filter(_ sender: UIButton) {
        
//        aggregateCall()
    }
    
    
    @IBAction func tap_summaryButton(_ sender: UIButton) {
        print("tap_summaryButton")
        if isUpdatePageDisplayed {
            summaryTab_View .backgroundColor = UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0)
            DetailTab_View .backgroundColor = .white
            isUpdatePageDisplayed = false
            
            UIView .transition(with: flipView, duration: 0.5, options:.showHideTransitionViews, animations: {
                self.subView_summary.isHidden = false
                self.subView_Detail.isHidden = true
            }) { (Finished) in
            }
        }
        
    }
    @IBAction func tap_detailButton(_ sender: UIButton) {
        print("tap_detailButton")
        if !isUpdatePageDisplayed {
            print("tap_detailButton")
            summaryTab_View .backgroundColor = .white
            DetailTab_View .backgroundColor = UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0)
            isUpdatePageDisplayed = true
            
            UIView .transition(with: flipView, duration: 0.5, options:.showHideTransitionViews, animations: {
                self.subView_summary.isHidden = true
                self.subView_Detail.isHidden = false
            }) { (Finished) in
            }
        }
    }
    
    // MARK: - ApiCall
    
    func aggregateCall()  {
        
       Apicall.sharedInstance.addLoader()
        let url = String(format: "http://10.232.35.2:8080/v1/aggregate")
        let paramdata = ["toTid" : tidTo_TextField.text ?? "" , "fromDate" : dateFrom_TextField.text ?? "" ,"toDate": dateTo_TextField.text ?? "", "fromTid" : tidFrom_textField.text ?? "" ] as [String : Any]
//        "0000356000000"
        
         print("paramdata--- \(paramdata)")
        
        Apicall.sharedInstance.sendPOSTDataWithoutDataKey(serviceUrl: url, parameters: paramdata) { (isSuccesfull, response) in
          
            if isSuccesfull {
                let responseStr = response as! String
                let data = Data(responseStr.utf8)
                do {
                    let decoder = JSONDecoder()
//                    let payData = try decoder.decode(PayResponse.self, from: data)
//                    self.response = payData;
//                    print("payData response is ",payData)
                    
                    let aggregateData = try decoder.decode(AggregateTransationData.self, from: data)
                    print(aggregateData.detailData ?? "")
                    self.detailData = aggregateData.detailData ?? []
                    self.aggregateData_ = aggregateData.aggregateData ?? []
                Apicall.sharedInstance.removeLoader()
                } catch {
                    Apicall.sharedInstance.removeLoader()
                    print("data not parse properly")
                }
                
            } else {
                Apicall.sharedInstance.removeLoader()
                 print(" call fail")
            }
         
    }
 }
    // MARK: - number tool bar
    
    func numberToolbarForKeyBoard(textFiled : UITextField)
    {
        self.numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        self.numberToolbar?.barStyle = .default
        self.numberToolbar?.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        self.numberToolbar?.sizeToFit()
        textFiled.inputAccessoryView = self.numberToolbar
    }
    

    @objc func doneWithNumberPad() {
       dateTo_TextField.resignFirstResponder()
        dateFrom_TextField.resignFirstResponder()
    
    }
    
     // MARK: - date picker
    
    func displayDatePicker(textfield : UITextField)
    {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePickerView.backgroundColor = UIColor.white
        
        if textfield == dateTo_TextField {
            datePickerView.tag = 1
        } else{
             datePickerView .tag = 2
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"       //"dd-MM-yyyy HH"
        let date = Date()
        
        textfield.inputView = datePickerView
        datePickerView.setDate(date, animated: false)
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControl.Event.allEvents)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy HH"
        print("datePickerValueChanged method ",dateFormatterPrint.string(from: sender.date))
        if sender.tag == 1 {
             self.dateTo_TextField.text = dateFormatterPrint.string(from: sender.date)
        }else {
            self.dateFrom_TextField.text = dateFormatterPrint.string(from: sender.date)
            
        }
       
       
    }
    
    // MARK:  - Api CAll
    
    
    
    func testCallAGgregateApi() {
        
        let Url = String(format: "http://10.232.35.2:8080/v1/aggregate")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["ToTID" : "", "FromDate" : "2019-09-15" ,"ToDate": "", "FromTID" : "0000356000000" ] ////YYYY-MM-DD HH:II
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func readJson()
    {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let str = String(data: data, encoding: .utf8)
                print ("response is",str ?? "" )
                let _data = Data(str!.utf8)

                let decoder = JSONDecoder()
                let aggregateData = try decoder.decode(AggregateTransationData.self, from: _data)
                print(aggregateData.detailData!)
                self.detailData = aggregateData.detailData!
                self.aggregateData_ = aggregateData.aggregateData!
            } catch {
                // handle error
            }
        }
    }
    



}


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



