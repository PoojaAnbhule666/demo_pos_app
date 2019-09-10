//
//  CardRefundViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

class CardProcessViewController: UIViewController , PinOnGlass_Delegate{

    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var statusMsgLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var slipNo : String = ""
    var amount : String = ""
    var isRefund = false

    
    var payment : PinOnGlass = PinOnGlass()
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.hidesBackButton = true
        setIntialSettings()
        startTransactionProcess()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationItem .setHidesBackButton(true, animated: true)
    }
    
    
    func setIntialSettings() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 98, height: 58))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        cancelBtn.isHidden = true
        
    }

    
    func startTransactionProcess() {
        print("refund request for slip number ",slipNo)
        
        payment = PinOnGlass.shared(Delegate: self)
        
        if(isRefund) {
              payment.startRefund(slipNumber: self.slipNo, dAmount: Double(self.amount ) ?? 0.0, sSeqNumber: "1234567", sProductCategoryCode: "1234567", sDeviceName: "IDT23181")
        }
        else {
        payment.startTransaction(dAmount: Double(amount ?? "0.00") as! Double, sSeqNumber: "asdasd", sProductCategoryCode: "001", sDeviceName: "IDT23181")
        }
        
    }
    
    
    
    func paySuccess(response: NSDictionary) {
        // logTextView.text = "Transaction Complete"
       
        print("response is ..." , response)
        
    
        
        
        
        
  
        
        statusLable.backgroundColor = .green
        //statusLable.text = "Transaction Complete"
        statusMsgLabel.textColor = .green
        statusMsgLabel.text = "Transaction Complete"
        
        if(!isRefund) {
            
            statusLable.backgroundColor = .green
            //statusLable.text = "Refund Complete"
            statusMsgLabel.textColor = .green
            statusMsgLabel.text = "Transaction Complete"
        }
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let completeVC = storyboard.instantiateViewController(withIdentifier: "CompleteTransactionViewController") as! CompleteTransactionViewController
        completeVC.payDictory = response
        if(isRefund) {
            completeVC.requestType = "Refund"
        }
        else {
            completeVC.requestType = "Pay"
        }
        self.navigationController?.pushViewController(completeVC, animated: true)
    }
    
    func payError(error: MessageData, response: NSObject) {
        print("----------ERROR -------------")
        
//        C014
        
        statusLable.backgroundColor = .red
        //statusLable.text = error.Message
        statusMsgLabel.textColor = .red
        statusMsgLabel.text = error.Message
        print(error.Code)
        print(error.Message)
        
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(showCancelButton), userInfo: nil, repeats: false)
      
       
    }
    
    
    @objc func showCancelButton() {
         cancelBtn.isHidden = false
        }
    
    
    func payMessage(message: MessageData) {
        print("----------MESSAGE -------------")
        
        statusLable.backgroundColor = .green
        //statusLable.text = message.Message
        statusMsgLabel.textColor = UIColor(red: 0.0/255, green: 143/255, blue: 0.0/255, alpha: 1.0)
        statusMsgLabel.text =  message.Message
        
    }
    
    @objc func landToMenuVc() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func cancelMethod(_ sender: UIButton) {
        
        if(statusMsgLabel.text == "Bluetooth disabled" || statusMsgLabel.text == "Connection lost to device"){
            
            //@TODO: disconnect bluetooth
            
        }
        else{
            payment.cancelTransaction()
        }
        self.navigationController?.popViewController(animated: true)
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
