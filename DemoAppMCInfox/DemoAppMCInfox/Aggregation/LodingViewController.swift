//
//  LodingViewController.swift
//  ifflSwift
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
//import FullMaterialLoader

@available(iOS 11.0, *)

class LodingViewController: UIViewController {
    
    @IBOutlet weak var customIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    var indicator : MaterialLoadingIndicator!
    
    let colorTheme = UIColor(named: "ColorTheme")
    override func viewDidLoad() {
        super.viewDidLoad()
        //      print("customIndicator")
        // Do any additional setup after loading the view.
        //        customIndicator.startAnimating()
        //        customIndicator.color = .colorTheme
        //        loadingView.layer.cornerRadius = 4;
        //        loadingView.layer.shadowRadius = 4
        //        loadingView.layer.shadowOpacity = 0.5
        //        loadingView.layer.shadowOffset = CGSize.zero
        self.configView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configView(){
        indicator = MaterialLoadingIndicator(frame: CGRect(x: loadingView.frame.size.width/2-30, y: loadingView.frame.size.height/2-30, width: 60, height: 60))
        //        indicator.indicatorColor = [UIColor.green.cgColor, UIColor.blue.cgColor]
        indicator.indicatorColor = [UIColor(red: 90/255.0, green: 136/255.0, blue: 194/255.0, alpha: 1.0).cgColor]
        
        //        indicator.center = self.content_View.center
        self.loadingView.addSubview(indicator)
        indicator.startAnimating()
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
