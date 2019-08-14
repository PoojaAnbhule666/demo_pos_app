//
//  productTableViewCell.swift
//  DemoCart
//
//  Created by CAFIS_Mac_1 on 29/07/19.
//  Copyright © 2019 CAFIS_Mac_1. All rights reserved.
//

import UIKit

class productTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var product_Name_Lable: UILabel!
    @IBOutlet weak var product_Price_Lable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       selectionStyle = .none
    }

}

