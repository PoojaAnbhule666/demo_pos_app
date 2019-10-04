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
    @IBOutlet weak var status_SegmentControl: UISegmentedControl!
    
    var numberToolbar:UIToolbar? = nil
    var currentTextField:UITextField? = nil
    var  isUpdatePageDisplayed : Bool = false
    var detailData = [DetailData]()
    var aggregateArr = [AggregateData]()
    var aggregationRequest : AggregationRequest = AggregationRequest()
    let colorSucess = UIColor(named: "ColorSucces")
    var statusTranc = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentdate()
        self.displayDatePicker(textfield: self.dateTo_TextField)
        self.displayDatePicker(textfield: self.dateFrom_TextField)
        
        numberToolbarForKeyBoard(textFiled: dateTo_TextField)
        numberToolbarForKeyBoard(textFiled: dateFrom_TextField)
        summaryTab_View .backgroundColor =  UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0)
        DetailTab_View .backgroundColor = .white
        summaryTab_View.layer.cornerRadius = 12
        DetailTab_View.layer.cornerRadius = 12
        
        tidFrom_textField.delegate = self
        tidTo_TextField.delegate = self
    }
    
    
    // MARK: - Load controllers
    
    func loadController()  {
        let summaryVc = self.storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        self .addChild(summaryVc)
        summaryVc.view.frame = subView_summary.bounds
        summaryVc.aggregateSummaryData = aggregateArr
        if summaryVc.aggregateSummaryData.count != 0 {
            summaryVc.nodataView.alpha = 0
        }else {
            summaryVc.nodataView.alpha = 1
        }
        subView_summary .addSubview(summaryVc.view)
        self .addChild(summaryVc)
        summaryVc .didMove(toParent: self)
        summaryVc.totalcount_TableView.reloadData()
        
        let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self .addChild(detailVc)
        detailVc.view.frame = subView_Detail.bounds
        detailVc.detailData_ = detailData
        if detailVc.detailData_.count != 0 {
            detailVc.nodataView.alpha = 0
        }else {
            detailVc.nodataView.alpha = 1
        }
        subView_Detail .addSubview(detailVc.view)
        self .addChild(detailVc)
        detailVc .didMove(toParent: self)
        detailVc.aggregateDetail_TableView.reloadData()
    }
    
    
    func setCurrentdate()  {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH"
        let formattedDate =
            format.string(from: date)
        //        print("formattedDate---\(formattedDate)")
        //        current_Date = formattedDate
        //        filteredDate(date: current_Date)
        dateFrom_TextField.text = formattedDate
        
    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func tapped_Clear(_ sender: Any) {
        
        tidFrom_textField.text = ""
        tidTo_TextField.text = ""
        dateFrom_TextField.text = ""
        dateTo_TextField.text = ""
        
        tidFrom_textField.resignFirstResponder()
        tidTo_TextField.resignFirstResponder()
        dateTo_TextField.resignFirstResponder()
        dateFrom_TextField.resignFirstResponder()
    }
    
    @IBAction func tap_filter(_ sender: UIButton) {
        //                 readJson()
        //         loadController()
        print("--------")
        tidFrom_textField.resignFirstResponder()
        tidTo_TextField.resignFirstResponder()
        dateTo_TextField.resignFirstResponder()
        dateFrom_TextField.resignFirstResponder()
//         readJson()
        aggregateCall()
        
    }
    
    // MARK: - Button Tapped & Switch
    
    @IBAction func staus_Switch(_ sender: Any) {
        switch status_SegmentControl.selectedSegmentIndex {
        case 0:
            statusTranc = "" // for all
        case 1:
            statusTranc = "0" // for complete transaction
        case 2:
            statusTranc = "1" // for Incomplete transaction
        default:
            break
        }
    }
    
    @IBAction func tap_summaryButton(_ sender: UIButton) {
        if isUpdatePageDisplayed {
            summaryTab_View .backgroundColor = UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0)
            DetailTab_View .backgroundColor = .white
            isUpdatePageDisplayed = false
            
            UIView .transition(with: flipView, duration: 0.5, options:.showHideTransitionViews, animations: {
                //                 showHideTransitionViews
                self.subView_summary.isHidden = false
                self.subView_Detail.isHidden = true
            }) { (Finished) in
            }
        }
        
    }
    @IBAction func tap_detailButton(_ sender: UIButton) {
        if !isUpdatePageDisplayed {
            
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
    
    func displayDatePicker(textfield : UITextField) {
        
       print("displayDatePicker")
        
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
         setCurrentdate()
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
         print("datePickerValueChanged")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH"  //"yyyy-MM-dd HH" dd-MM-yyyy HH"
        //            print("datePickerValueChanged method ",dateFormatterPrint.string(from: sender.date))
        if sender.tag == 1 {
            self.dateTo_TextField.text = dateFormatterPrint.string(from: sender.date)
        }else {
            self.dateFrom_TextField.text = dateFormatterPrint.string(from: sender.date)
            
        }
        
        
    }
    
    
    // MARK: - ApiCall
    
    func aggregateCall()  {
        
        
        Apicall.sharedInstance.addLoader()
        
        let url = String(format: "http://10.232.35.5:8080/v1/aggregate")
        var  paramdata = ["fromTid" : tidFrom_textField.text ?? "" , "status" : statusTranc] as [String : Any]
        //        "0000356000000"
        
        if(dateFrom_TextField.text != "") {
            paramdata["fromDate"] = dateFrom_TextField.text        }
        
        if(dateTo_TextField.text != "") {
            paramdata["toDate"] = dateTo_TextField.text        }
        
        if(tidTo_TextField.text != "" ) {
            paramdata["toTid"] = tidTo_TextField.text
        }
        
        print("paramdata--- \(paramdata)")
        
        
        Apicall.sharedInstance.sendPOSTDataWithoutDataKey(serviceUrl: url, parameters: paramdata) { (isSuccesfull, response) in
            
            if isSuccesfull {
                let responseStr = response as! String
                let data = Data(responseStr.utf8)
                do {
                    let decoder = JSONDecoder()
                    
                    let aggregateData = try decoder.decode(AggregateTransationData.self, from: data)
//                    print("aggregateData.detailData",aggregateData.detailData ?? "")
                    //                            self.detailData = aggregateData.detailData ?? []
                    
                    var salesData = [DetailData]()
                    var refundData = [DetailData]()
                    self.detailData = aggregateData.detailData ?? []
                    for data in self.detailData {
                        
                        if( data.paymentStatus == "0") {
                            salesData.append(data)
                        }
                        else { // data.status = 1
                            refundData.append(data)
                        }
                    }
                    
                    self.detailData.removeAll()
                    self.detailData = salesData + refundData
                    self.aggregateArr.removeAll()
                    self.aggregateArr = aggregateData.aggregateData ?? []
                    var arrayIndex = 0
                    for data in self.aggregateArr {
                        arrayIndex += 1
                        if ( data.sales?.totalCountComplete == 0 && data.refund?.totalCountComplete == 0) {
                            self.aggregateArr.remove(at: arrayIndex - 1 )
                            arrayIndex -= 1
                            
                        }
                    }
                    
                    self.loadController()
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
    
    //--- thrugh json file
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
                //print(aggregateData.detailData!)
                var salesData = [DetailData]()
                var refundData = [DetailData]()
                self.detailData = aggregateData.detailData!
                for data in self.detailData {
                    
                    if( data.paymentStatus == "0") {
                        salesData.append(data)
                    }
                    else { // data.status = 1
                        refundData.append(data)
                    }
                }
                
                self.detailData.removeAll()
                self.detailData = salesData + refundData
                // self.detailData = aggregateData.detailData
        
               
                self.aggregateArr = aggregateData.aggregateData!
                
                var arrayIndex = 0
                for data in self.aggregateArr {
                    arrayIndex += 1
                    if ( data.sales?.totalCountComplete == 0 && data.refund?.totalCountComplete == 0) {
                        aggregateArr.remove(at: arrayIndex - 1 )
                        arrayIndex -= 1
                        
                    }
                }
                
                self.loadController()
                
            } catch {
                // handle error
            }
        }
    }
}






