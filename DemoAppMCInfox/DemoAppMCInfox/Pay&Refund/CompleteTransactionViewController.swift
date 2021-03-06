//
//  RefundCompleteViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass


@available(iOS 11.0, *)
class CompleteTransactionViewController: UIViewController {

     @IBOutlet weak var homeBtn: UIButton!
     @IBOutlet weak var amountLbl: UILabel!
     @IBOutlet weak var cardTypeLbl: UILabel!
     @IBOutlet weak var slipNumberLbl: UILabel!
     @IBOutlet weak var requestTypeLbl: UILabel!
     @IBOutlet weak var statusRequestLabel: UILabel!
     @IBOutlet weak var payRequestView: UIView!
     @IBOutlet weak var imageTran: UIImageView!
    
     var requestType : String = ""
     var payDictory : NSDictionary = [:]
     let greenColor = UIColor(named: "ColorSucces")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in complete details")
        NotificationCenter.default.addObserver(self,selector:#selector(cancelUpdate(_:)),name: NSNotification.Name ("CancelTransaction"),                                           object: nil)
       // setIntialSettings()
        setDetails()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       self.navigationItem .setHidesBackButton(true, animated: true)
    }

    
    override func viewDidDisappear(_ animated: Bool) {
         NotificationCenter.default
          .removeObserver(self, name:  NSNotification.Name("CancelTransaction"), object: nil)
    }
    
    func setIntialSettings() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 98, height: 58))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
    }
    
    func setDetails() {
        amountLbl.text = payDictory["amount"] as? String
        slipNumberLbl.text = payDictory["slipNumber"] as? String
        cardTypeLbl.text = payDictory["brandName"] as? String
        requestTypeLbl.text = requestType
        if(requestType == "Refund")
        {
            requestTypeLbl.textColor = .red
        }
        else {
             requestTypeLbl.textColor = greenColor
        }
        
    }
    
    
     @IBAction func homeMethod(_ sender: UIButton) {
        
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func cancelUpdate(_ notification: Notification){
        print("in cancelUpdate notification")
       let image = UIImage(named: "cancel")
       imageTran.image = image
       statusRequestLabel.text = "Cancel Transaction done for below request"
        
    }
   
}
