//
//  RefundCompleteViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit
import PinOnGlass

class CompleteTransactionViewController: UIViewController {

     @IBOutlet weak var homeBtn: UIButton!
     @IBOutlet weak var amountLbl: UILabel!
     @IBOutlet weak var cardTypeLbl: UILabel!
     @IBOutlet weak var slipNumberLbl: UILabel!
     @IBOutlet weak var requestTypeLbl: UILabel!
     var requestType : String = ""
     var payDictory : NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in complete details")
       // setIntialSettings()
        setDetails()

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
             requestTypeLbl.textColor = UIColor (red: 40.0/255.0, green: 128.0/255.0, blue: 95/255.0, alpha: 1.0)
        }
        
    }
    
    
     @IBAction func homeMethod(_ sender: UIButton) {
        
         self.navigationController?.popToRootViewController(animated: true)
    }
   
}
