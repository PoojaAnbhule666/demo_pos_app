//
//  ViewController.swift
//  DemoCart
//
//  Created by CAFIS_Mac_1 on 29/07/19.
//  Copyright © 2019 CAFIS_Mac_1. All rights reserved.
//

import UIKit
//import CoreBluetooth
import PinOnGlass

class ShopViewController: UIViewController ,PinOnGlass_Delegate  {
    
    @IBOutlet weak var product_TableView: UITableView!
    @IBOutlet weak var total_Price_Lable: UILabel!
    
    @IBOutlet weak var pay_Button: UIButton!
    @IBOutlet weak var clear_button: UIButton!
    
    //    var manager:CBCentralManager!
    var
    
    CafisFramework: PinOnGlass?
    var productArray = [["Price" : "2000" ,"Product Name" : "iPhone xs max"],["Price" : "1500" ,"Product Name" : "iphone xr"],["Price" : "1200" ,"Product Name" : "iphone x"],["Price" : "1000" ,"Product Name" : "iphone 8 plus"],["Price" : "800" ,"Product Name" : "iphone 8"],["Price" : "600" ,"Product Name" : "iphone 7 plus"],["Price" : "500" ,"Product Name" : "iphone 7"],["Price" : "2200" ,"Product Name" : "ipad Pro"],["Price" : "2500" ,"Product Name" : "macBook pro"]]
    
    var selcetedItemArray = [String] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        manager  = CBCentralManager()
        //        manager.delegate = self
        
        self.CafisFramework = PinOnGlass(Delegate: self);
        self.CafisFramework?._Delegate = self;
        
        selcetedItemArray.removeAll()
        
        if total_Price_Lable.text == "0.0 ¥" {
            clear_button.isEnabled = false
            clear_button.alpha = 0.5
        }else {
            clear_button.isEnabled = true
            clear_button.alpha = 1
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        print("Transaction  Cancelled")
        self.CafisFramework?.cancel();
    }


    @IBAction func clear(_ sender: UIButton) {
        selcetedItemArray.removeAll()
        total_Price_Lable.text = "0.0 ¥"
        clear_button.isEnabled = false
        clear_button.alpha = 0.5
        
    }
    @IBAction func Pay(_ sender: UIButton) {
        print("Transaction  Started")
        let dAmount: Double = 10 ;
        //dAmount = total_Price_Lable?.text
        self.CafisFramework?.startTransaction(dAmount: dAmount, sSeqNumber: "ttt", sProductCategoryCode: "000",sDeviceName: "");
    }
    
    func paySuccess(response: NSObject) {
        print("Message");
    }
    
    func payError(error: MessageData, response: NSObject) {
        print("----------ERROR -------------")
        print(error.Code);
        print(error.Message)
    }
    
    func payMessage(message: MessageData) {
        print("----------MESSAGE -------------")
        print(message.Code);
        print(message.Message)
    }
    
}




extension ShopViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! productTableViewCell
            cell.product_Name_Lable.text = productArray[indexPath.row]["Product Name"]
        let priceValue = ("\(productArray[indexPath.row]["Price"] ?? "") ¥")
            cell.product_Price_Lable.text = priceValue
        
        return cell
    }
    
}

extension ShopViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selcetedItemArray.append(productArray[indexPath.row]["Price"] ?? "0")
        print("selcetedItemArray --- \(selcetedItemArray)")
     self.displayPrize()
        
        
    }
    
    func displayPrize () {
        var totalPrize = 0
        
        for slectedValue in selcetedItemArray {
            let value  = slectedValue
           // print("value --- \(value)" )
            totalPrize += Int(value) ?? 0
            print("totalPrize --- \(totalPrize)" )
            
        }
        let totalvalue = ("\(String(totalPrize)) ¥")
        total_Price_Lable.text = totalvalue
        clear_button.isEnabled = true
        clear_button.alpha = 1

    }
}

