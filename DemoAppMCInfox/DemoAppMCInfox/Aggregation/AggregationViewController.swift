//
//  AggregationViewController.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 11/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class AggregationViewController: UIViewController {
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

        // Do any additional setup after loading the view.
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
