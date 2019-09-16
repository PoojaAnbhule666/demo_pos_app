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
    
    var  isUpdatePageDisplayed : Bool = false
    
    var productArray = [
        ["Price" : "10000" ,"Product Name" : "Success : AMEX CARD"],
        ["Price" : "500" ,"Product Name" : "Success : VISA CARD"],
        ["Price" : "600" ,"Product Name" : "Success : MASTER CARD"],
        ["Price" : "700" ,"Product Name" : "Success : JCB CARD"],
        ["Price" : "900" ,"Product Name" : "Success : DINERS CARD"],
        ["Price" : "1000" ,"Product Name" : "Rejected by issuer"],
        ["Price" : "2000" ,"Product Name" : "Error from CAFIS server"],
        ["Price" : "3000" ,"Product Name" : "System Error : CAFIS GW"],
        ["Price" : "4000" ,"Product Name" : "Success : E211 received"],
        ["Price" : "5000" ,"Product Name" : "Failure : E212 received"],
        ["Price" : "5500" ,"Product Name" : "Success : E212 received"],
        ["Price" : "6000" ,"Product Name" : "Timeout : CAFIS server"],
        ["Price" : "1100" ,"Product Name" : "Card rejected by issuer"],
        ["Price" : "2100" ,"Product Name" : "Card error from CAFIS"],
        ["Price" : "3100" ,"Product Name" : "CAFIS sys error"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        //        isUpdatePageDisplayed = true
        //        tap_summaryButton(nil)
        summaryTab_View .backgroundColor = .blue
        DetailTab_View .backgroundColor = .white
        
        summaryTab_View.layer.cornerRadius = 12
        DetailTab_View.layer.cornerRadius = 12
        
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
