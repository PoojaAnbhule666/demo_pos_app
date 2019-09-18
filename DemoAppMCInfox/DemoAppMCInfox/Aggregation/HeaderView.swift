//
//  HeaderView.swift
//  ExpandTableView
//
//  Created by CAFIS_Mac_1 on 17/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderViewDelegate {
    func toggleSection(_ section: Int)
}

class HeaderView : UITableViewHeaderFooterView {
    
    @IBOutlet weak var checkPayView: UIView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var number_Label: UILabel!
    @IBOutlet weak var brandName_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    @IBOutlet weak var checkOk_label: UILabel!
    @IBOutlet weak var amount_Label: UILabel!
    
    
    var delegate: HeaderViewDelegate?
    var section: Int = 0
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderView.tapHeader(_:))))
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? HeaderView else {
            return
        }
        _ = delegate?.toggleSection(cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        
    }
    
}
extension UIColor {
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
}

extension UIView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
   }

}
