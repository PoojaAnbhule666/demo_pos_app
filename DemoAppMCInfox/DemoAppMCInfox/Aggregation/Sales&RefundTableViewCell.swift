//
//  Sales&RefundTableViewCell.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 11/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class Sales_RefundTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comapnyName_Label: UILabel!
    @IBOutlet weak var sale_totalCountComplete: UILabel!
    @IBOutlet weak var sale_totalAmountCOmplete_label: UILabel!
    //Sales&rRefundCell reuseIdentifier name
    @IBOutlet weak var refund_TotalCountComplete_Label: UILabel!
    @IBOutlet weak var refund_TotalAmountComplete_Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
