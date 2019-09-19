//
//  ExpandCell.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 16/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class ExpandCell: UITableViewCell {

    @IBOutlet weak var tid_label: UILabel!
    @IBOutlet weak var orgSlipNo_label: UILabel!
    @IBOutlet weak var paymentDivison_Label: UILabel!
    @IBOutlet weak var approveNo_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var errorCode_label: UILabel!
    @IBOutlet weak var autoCancelSts_label: UILabel!
    @IBOutlet weak var captureSend_label: UILabel!
    @IBOutlet weak var processingNo_label: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
