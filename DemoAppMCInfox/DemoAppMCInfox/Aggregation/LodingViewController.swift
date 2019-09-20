//
//  LodingViewController.swift
//  ifflSwift
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)

class LodingViewController: UIViewController {

    @IBOutlet weak var customIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    let colorTheme = UIColor(named: "ColorTheme")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customIndicator.startAnimating()
        customIndicator.color = colorTheme
        loadingView.layer.cornerRadius = 4;
        loadingView.layer.shadowRadius = 4
        loadingView.layer.shadowOpacity = 0.5
        loadingView.layer.shadowOffset = CGSize.zero
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
