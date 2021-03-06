        //
        //  SummaryViewController.swift
        //  DemoAppMCInfox
        //
        //  Created by CAFIS_Mac_1 on 16/09/19.
        //  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
        //
        
        import UIKit
        
        class SummaryViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
            @IBOutlet weak var nodataView: UIView!
            @IBOutlet weak var totalcount_TableView: UITableView!
            
            var aggregateSummaryData = [AggregateData]()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                // Do any additional setup after loading the view.
                totalcount_TableView.estimatedRowHeight = 100.0
                totalcount_TableView.rowHeight = UITableView.automaticDimension
                
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return aggregateSummaryData.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let Cell = tableView.dequeueReusableCell(withIdentifier: "Sales&rRefundCell") as! Sales_RefundTableViewCell
                
                Cell.comapnyName_Label.text = aggregateSummaryData[indexPath.row].companyName
                Cell.sale_totalCountComplete.text = String(aggregateSummaryData[indexPath.row].sales!.totalCountComplete!)
                Cell.sale_totalAmountCOmplete_label.text = String(aggregateSummaryData[indexPath.row].sales!.amountComplete!)
                
                Cell.refund_TotalCountComplete_Label.text = String(aggregateSummaryData[indexPath.row].refund!.totalCountComplete!)
                Cell.refund_TotalAmountComplete_Label.text = String(aggregateSummaryData[indexPath.row].refund!.amountComplete!)
                
                return Cell
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 80.0
            }
            func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
                return 40.0
            }
        }
        
