//
//  CardRefundViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

@available(iOS 11.0, *)
class CardProcessViewController: UIViewController , PinOnGlass_Delegate{

    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var statusMsgLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var slipNo : String = ""
    var amount : String = ""
    var isRefund = false
    var isCancel = false
    let greenColor = UIColor(named: "ColorSucces")

    
    var payment : PinOnGlass = PinOnGlass()
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.hidesBackButton = true
        startTransactionProcess()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationItem .setHidesBackButton(true, animated: true)
    }
    
    func startTransactionProcess() {
        
        payment = PinOnGlass.shared(Delegate: self)
        
        if(isRefund) {
              payment.startRefund(slipNumber: self.slipNo, dAmount: Double(self.amount ) ?? 0.0, sSeqNumber: "1234567", sProductCategoryCode: "1234567", sDeviceName: "IDTECH3187")
        }
        else {
        payment.startTransaction(dAmount: Double(amount ?? "0.00") as! Double, sSeqNumber: "asdasd", sProductCategoryCode: "001", sDeviceName: "IDTECH3187")
        }
        
    }
    
    
    
    func paySuccess(response: NSDictionary) {
        // logTextView.text = "Transaction Complete"
        print("response is ..." , response)
        
        statusLable.backgroundColor = greenColor
        //statusLable.text = "Transaction Complete"
        statusMsgLabel.textColor = greenColor
        statusMsgLabel.text = "Transaction Complete"
        
        if(!isRefund) {
            
            statusLable.backgroundColor = greenColor
            //statusLable.text = "Refund Complete"
            statusMsgLabel.textColor = greenColor
            statusMsgLabel.text = "Transaction Complete"
        }
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let completeVC = storyboard.instantiateViewController(withIdentifier: "CompleteTransactionViewController") as! CompleteTransactionViewController
        completeVC.payDictory = response
        if(isRefund) {
            completeVC.requestType = "Refund"
             self.navigationController?.pushViewController(completeVC, animated: true)
        }
        else if(isCancel) {
            completeVC.requestType = "Cancel"
        }
        else {
            completeVC.requestType = "Pay"
             self.navigationController?.pushViewController(completeVC, animated: true)
        }
       
    }
    
    func payError(error: MessageData, response: NSObject) {
        print("----------ERROR ------------- ", error.Code)
        statusLable.backgroundColor = .red
        //statusLable.text = error.Message
        statusMsgLabel.textColor = .red
        statusMsgLabel.text = error.Message
        if (error.Code == "C003" || error.Code == "C010") {
            isCancel = false
        }
    }
    
    
    func payMessage(message: MessageData) {
        print("----------MESSAGE -------------",message.Code)
        
        statusLable.backgroundColor = greenColor
        //statusLable.text = message.Message
        statusMsgLabel.textColor = UIColor(red: 0.0/255, green: 143/255, blue: 0.0/255, alpha: 1.0)
        statusMsgLabel.text =  message.Message

        if (message.Code == "M013") {
             statusMsgLabel.textColor = .red
             self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func landToMenuVc() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func cancelMethod(_ sender: UIButton) {
        
        if(!isCancel) {
            print("cancel button clicked")
            isCancel = true
            if(payment._inTransaction == 0){
                print("cancel button clicked , in transaction 0")
                payment.cancelInMiddle()
                self.navigationController?.popViewController(animated: true)
            }
            else {
                print("cancel button clicked , in transaction 1")
                payment.callCancel()
            }
        }
    }
    
}
