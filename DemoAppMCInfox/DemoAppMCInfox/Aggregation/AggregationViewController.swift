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
    
    let colorSucess = UIColor(named: "ColorSucces")

    override func viewDidLoad() {
        super.viewDidLoad()
        //        isUpdatePageDisplayed = true
        //        tap_summaryButton(nil)
//        dateFrom_TextField.delegate = self
//        dateTo_TextField.delegate = self
//
        self.displayDatePicker(textfield: self.dateTo_TextField)
        self.displayDatePicker(textfield: self.dateFrom_TextField)
         readJson()
        loadController()
        numberToolbarForKeyBoard(textFiled: dateTo_TextField)
          numberToolbarForKeyBoard(textFiled: dateFrom_TextField)
        summaryTab_View .backgroundColor =  UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0)
        DetailTab_View .backgroundColor = .white
        
        summaryTab_View.layer.cornerRadius = 12
        DetailTab_View.layer.cornerRadius = 12
       
//        dataFromfile()
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
    
//    @objc func doneWithNumberPad()
//    {
//        self.currentTextField?.resignFirstResponder()
//
//    }
    
     // MARK: - number date picker
    
    func displayDatePicker(textfield : UITextField)
    {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.backgroundColor = UIColor.white
        if textfield == dateTo_TextField {
            datePickerView.tag = 1
        } else{
             datePickerView .tag = 2
        }
        
//        let dateString = "01-01-1990"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let date = dateFormatter.date(from: dateString)
        let date = Date()
        
        textfield.inputView = datePickerView
        datePickerView.setDate(date, animated: false)
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControl.Event.allEvents)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"
        print("datePickerValueChanged method ",dateFormatterPrint.string(from: sender.date))
        if sender.tag == 1 {
             self.dateTo_TextField.text = dateFormatterPrint.string(from: sender.date)
        }else {
            self.dateFrom_TextField.text = dateFormatterPrint.string(from: sender.date)
            
        }
       
       
    }
    
    
    
//    func dataFromfile () {
//    if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
//        do {
//
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            do {
//
//                let decoder = JSONDecoder()
//
//                let dataList = try decoder.decode(AggregateTransationData.self, from: data)
//                print("DAta List",dataList)
//            } catch {
//                // handle error
//            }
//
//        } catch {
//            // handle error
//        }
//    }
//}

    
    
    
    
    
    func readJson()
    {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               let str = String(data: data, encoding: .utf8) as! String
                print ("response is",str )
                let _data = Data(str.utf8)

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



