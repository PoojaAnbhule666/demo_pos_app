//
//  MenuViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setInitialSettings()
      
        // Do any additional setup after loading the view.
    }
    
    func setInitialSettings() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 98, height: 100))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    
    @IBAction func payButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let payVC = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
//        self.present(slipVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(payVC, animated: true)
        
    }
    @IBAction func refund(_ sender: Any?) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let slipVC = storyboard.instantiateViewController(withIdentifier: "SlipNumberViewController") as! SlipNumberViewController
//        self.present(slipVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(slipVC, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
