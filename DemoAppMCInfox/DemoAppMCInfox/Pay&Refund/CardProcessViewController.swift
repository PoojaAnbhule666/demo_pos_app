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
class CardProcessViewController: UIViewController , UIScrollViewDelegate , PinOnGlass_Delegate{

    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var statusMsgLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var slipNo : String = ""
    var amount : String = ""
    var isRefund = false
    var isCancel = false
    let greenColor = UIColor(named: "ColorSucces")
    var gotresponse = false

    
    var payment : PinOnGlass = PinOnGlass()
    
    var activityIndicator = UIActivityIndicatorView()
       var strLabel = UILabel()

    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
   
   
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
              payment.startRefund(slipNumber: self.slipNo, dAmount: Double(self.amount ) ?? 0.0, sSeqNumber: "1234567", sProductCategoryCode: "1234567", sDeviceName: "") // idtech3187
        }
        else {
        payment.startTransaction(dAmount: Double(amount ?? "0.00") as! Double, sSeqNumber: "", sProductCategoryCode: "001", sDeviceName: "") // IDTECH3187
        }
        
    }
    
    
    
    func paySuccess(response: NSDictionary) {
        // logTextView.text = "Transaction Complete"
        print("response is ..." , response)
        
        statusLable.backgroundColor = greenColor
        //statusLable.text = "Transaction Complete"
        statusMsgLabel.textColor = greenColor
        statusMsgLabel.text = "Transaction Complete"
        gotresponse = true
        
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
        cancelBtn.setTitle("Back", for: .normal)
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

        
        
         if (message.Code == "M014" && gotresponse ) {
                    statusMsgLabel.textColor = .red
            NotificationCenter.default.post(name:  NSNotification.Name("CancelTransaction"),
                     object: nil)
        }
        else if (message.Code == "M014" && !gotresponse ) {
                    statusMsgLabel.textColor = .red
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let completeVC = storyboard.instantiateViewController(withIdentifier: "CompleteTransactionViewController") as! CompleteTransactionViewController
             completeVC.requestType = "Cancel"
             self.navigationController?.pushViewController(completeVC, animated: true)
        }
        if (message.Code == "M013") {
             statusMsgLabel.textColor = .red
             self.effectView.removeFromSuperview()
             self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func landToMenuVc() {
         self.effectView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func cancelMethod(_ sender: UIButton) {
        activityIndicator("Cancelling...")
        if(!isCancel) {
            print("cancel button clicked")
            isCancel = true
            if(payment._inTransaction == 0){
                print("cancel button clicked , in transaction 0")
                payment.cancelInMiddle()
                self.effectView.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
            else {
                print("cancel button clicked , in transaction 1")
                payment.callCancel()
            }
        }
    }
    
    
    
    
    
    func activityIndicator(_ title: String) {

           strLabel.removeFromSuperview()
           activityIndicator.removeFromSuperview()
           effectView.removeFromSuperview()

           strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
           strLabel.text = title
           strLabel.font = .systemFont(ofSize: 14, weight: .medium)
           strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)

           effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY + view.frame.midY/2 , width: 160, height: 46)
           effectView.layer.cornerRadius = 15
           effectView.layer.masksToBounds = true
           

           activityIndicator = UIActivityIndicatorView(style: .white)
           activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
           activityIndicator.startAnimating()

           effectView.contentView.addSubview(activityIndicator)
           effectView.contentView.addSubview(strLabel)
           effectView.alpha = 0.7
           effectView.backgroundColor = .white
           view.addSubview(effectView)
       }

    
}
