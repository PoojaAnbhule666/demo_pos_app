//
//  ViewController.swift
//  DemoCart
//
//  Created by CAFIS_Mac_1 on 29/07/19.
//  Copyright © 2019 CAFIS_Mac_1. All rights reserved.
/////////

import UIKit
import PinOnGlass



class ShopViewController: UIViewController, PinOnGlass_Delegate , UIAlertViewDelegate{
    
//    PinOnGlass_Delegate , UIAlertViewDelegate
    
    @IBOutlet weak var product_TableView: UITableView!
    @IBOutlet weak var total_Price_Lable: UILabel!
    
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLable: UILabel!
   // @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var pay_Button: UIButton!
    @IBOutlet weak var clear_button: UIButton!
    
    var refundCall = 0;
    
    
//    var productArray = [["Price" : "500" ,"Product Name" : "iPhone xs max"],["Price" : "1000" ,"Product Name" : "iphone xr"],["Price" : "2000" ,"Product Name" : "iphone x"],["Price" : "3000" ,"Product Name" : "iphone 8 plus"],["Price" : "4000" ,"Product Name" : "iphone 8"],["Price" : "5000" ,"Product Name" : "iphone 7 plus"],["Price" : "6000" ,"Product Name" : "iphone 7"],["Price" : "100" ,"Product Name" : "ipad Pro"]]
    
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
    
    var selcetedItemArray = [String] ()
    var moveToNextVC = 0
    
    var slipNo : String = ""
    var refund_amt : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {

        statusLable.textColor = .black
        statusLable.text = ""
        selcetedItemArray.removeAll()
        amountLabel.text = "¥ 0.0"
        taxLabel.text = "¥ 0.0"
        total_Price_Lable.text = "0.0"
        print("Transaction  Cancelled")
    }


    @IBAction func clear(_ sender: UIButton) {
        
//        logTextView.text = ""
        statusLable.textColor = .black
        statusLable.text = ""
        selcetedItemArray.removeAll()
        amountLabel.text = "¥ 0.0"
        taxLabel.text = "¥ 0.0"
        total_Price_Lable.text = "0.0"
      
    }
    
    
    @IBAction func refund_Button(_ sender: UIButton) {
        
        getSlipNumber()
        refundCall = 1;
        //let payment : PinOnGlass = PinOnGlass.shared(Delegate: self)
        
        //logTextView.text = "Refund Started"
        statusLable.textColor = .black
        statusLable.text = "Refund Started"
        
        if(self.slipNo == "" && self.refund_amt == "") {
            return;
        }
        
    
        
    }
    
    
    @IBAction func Pay(_ sender: UIButton) {
        print("Transaction  Started")
        
        if(total_Price_Lable.text == "") {
            return;
        }
        refundCall = 0;
        print("total amount is",total_Price_Lable.text ?? 0.0)
        if(total_Price_Lable.text != "0.0" ) { // amount validations
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cardVC = storyboard.instantiateViewController(withIdentifier: "CardProcessViewController") as! CardProcessViewController
            cardVC.amount = total_Price_Lable.text ?? "0.00"
            
            
            self.navigationController?.pushViewController(cardVC, animated: true)
        }
        else {
            statusLable.textColor = .red
            statusLable.text = "Select item"
        }
        
    }
    
    
     

    func paySuccess(response: NSDictionary) {
       // logTextView.text = "Transaction Complete"
        statusLable.textColor = .green
        statusLable.text = "Transaction Complete"

        if(refundCall == 1) {
            
            statusLable.textColor = .green
            statusLable.text = "Refund Complete"
        }

        selcetedItemArray.removeAll()
        total_Price_Lable.text = "0.0"
    }

    func payError(error: MessageData, response: NSObject) {
        print("----------ERROR -------------")

        statusLable.textColor = .red
        statusLable.text = error.Message
        print(error.Code)
        print(error.Message)


    }

    func payMessage(message: MessageData) {
        print("----------MESSAGE -------------", message.Code)

        statusLable.textColor = .green
        statusLable.text = message.Message
    }
   

    func getSlipNumber() {
        let alertController = UIAlertController(title: "Request For Refund", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            
            textField.placeholder = "Enter the slip no"
            
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
            let slipNo_Texfield = alertController.textFields![0] as UITextField
            let amount_TextField = alertController.textFields![1] as UITextField
            self.slipNo = slipNo_Texfield.text ?? ""
            self.refund_amt = amount_TextField.text ?? ""
            
            print("slip no  -- \(self.slipNo) refund amt--  \(self.refund_amt)")
//            if let txtField = alertController.textFields?.first, let text = txtField.text {
//                // operations
//
//                self.slipNo = text
//                print("Text==>" + text)
            
            if(self.slipNo == "" && self.refund_amt == "") {
                return;
            }
            
//            let payment : PinOnGlass = PinOnGlass.shared(Delegate: self)
            
//            payment.startRefund(slipNumber: self.slipNo, dAmount: Double(self.refund_amt ) ?? 0.0, sSeqNumber: "1234567", sProductCategoryCode: "1234567", sDeviceName: "IDT23181")

        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter amount"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}




extension ShopViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! productTableViewCell
            cell.product_Name_Lable.text = productArray[indexPath.row]["Product Name"]
        let priceValue = (" ¥ \(productArray[indexPath.row]["Price"] ?? "")")
            cell.product_Price_Lable.text = priceValue
        
        return cell
    }
    
}

extension ShopViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        selcetedItemArray.append(productArray[indexPath.row]["Price"] ?? "0")
//        print("selcetedItemArray --- \(selcetedItemArray)")
     self.displayPrize()
        
        
    }
    
    func displayPrize () {
        var totalPrize : Double = 0.0
        
        for slectedValue in selcetedItemArray {
            let value  = slectedValue
            totalPrize += Double(value) ?? 0
        }
        amountLabel.text = ("\(String(totalPrize))")
        let amountValue = totalPrize
        let percentAmount = ((6 * amountValue)/100)
        taxLabel.text = ("\(String(percentAmount))")
        
        
        let totalvalue = amountValue + percentAmount
        total_Price_Lable.text = ("\(String(totalvalue))")

        clear_button.isEnabled = true
        clear_button.alpha = 1

    }
}

