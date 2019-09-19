//
//  SummaryViewController.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 16/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    

    @IBOutlet weak var totalcount_TableView: UITableView!
    
     var _aggregateData = [AggregateData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        totalcount_TableView.estimatedRowHeight = 100.0
        totalcount_TableView.rowHeight = UITableView.automaticDimension
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _aggregateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Sales&rRefundCell") as! Sales_RefundTableViewCell
        
            Cell.comapnyName_Label.text = _aggregateData[indexPath.row].companyName
            Cell.sale_totalCountComplete.text = String(_aggregateData[indexPath.row].sales!.totalCountComplete!)
            Cell.sale_totalAmountCOmplete_label.text = String(_aggregateData[indexPath.row].sales!.amountComplete!)
        
           Cell.refund_TotalCountComplete_Label.text = String(_aggregateData[indexPath.row].sales!.totalCountComplete!)
           Cell.refund_TotalAmountComplete_Label.text = String(_aggregateData[indexPath.row].sales!.totalCountComplete!)
        
        
      
        return Cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}

