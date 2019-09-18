//
//  AggregationViewController.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 11/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit


class AggregationViewController: UIViewController {
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
    
    var  isUpdatePageDisplayed : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //        isUpdatePageDisplayed = true
        //        tap_summaryButton(nil)
        
//        loadController()
        summaryTab_View .backgroundColor = .blue
        DetailTab_View .backgroundColor = .white
        
        summaryTab_View.layer.cornerRadius = 12
        DetailTab_View.layer.cornerRadius = 12
        readJson()
        dataFromfile()
    }
    
    func loadController()  {
        let summaryVc = self.storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        self .addChild(summaryVc)
        summaryVc.view.frame = subView_summary.bounds
        subView_summary .addSubview(summaryVc.view)
        self .addChild(summaryVc)
        summaryVc .didMove(toParent: self)
        
        let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self .addChild(detailVc)
        detailVc.view.frame = subView_Detail.bounds
        subView_Detail .addSubview(detailVc.view)
        self .addChild(detailVc)
        detailVc .didMove(toParent: self)
    }
    
    @IBAction func tap_summaryButton(_ sender: UIButton) {
        print("tap_summaryButton")
        if isUpdatePageDisplayed {
            summaryTab_View .backgroundColor = .blue
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
            DetailTab_View .backgroundColor = .blue
            isUpdatePageDisplayed = true
            
            UIView .transition(with: flipView, duration: 0.5, options:.showHideTransitionViews, animations: {
                self.subView_summary.isHidden = true
                self.subView_Detail.isHidden = false
            }) { (Finished) in
            }
        }
    }
    
    

   
//    func getDataFromFile()   {
//
//
//            let path = Bundle.main.url(forResource: "Data", withExtension: "json")!
//        let data = try? Data(from: URL(fileURLWithPath: path))
//
//        }
    
    func dataFromfile () {
    if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
////            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//                // do stuff
//            }
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            do {
                
                let decoder = JSONDecoder()
//                let payData = try decoder.decode(PayResponse.self, from: data)
                let dataList = try decoder.decode(AggregateTransationData.self, from: data)
                print("DAta List",dataList)
            } catch {
                // handle error
            }
            
        } catch {
            // handle error
        }
    }
}

    
    func readJson()
    {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               let str = String(data: data, encoding: .utf8) as! String
                print ("response is",str )
                let _data = Data(str.utf8)

                let decoder = JSONDecoder()
                let payData = try decoder.decode(AggregateData.self, from: _data)
               
            } catch {
                // handle error
            }
        }
    }
    



}



