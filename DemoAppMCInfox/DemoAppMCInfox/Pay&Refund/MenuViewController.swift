//
//  MenuViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let menuLblArray = ["Pay","Money","Report","Refund","Wallet","Terminal Status" , "Register New Device"]
    
    let imageArray = ["pay","money","report","refund","wallet", "activation" ,"registerDevice" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuLblArray.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath as IndexPath) as! MenuCollectionViewCell
        cell.menuLbl.text = self.menuLblArray[indexPath.item]
        cell.menuImg.image = UIImage(named: imageArray[indexPath.item])
        cell.menuLbl.sizeToFit()
        cell.menuLbl.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
//        print("You selected cell #\(indexPath.item)!")
//        
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderWidth = 2.0
//        cell?.layer.borderColor = UIColor.gray.cgColor
        
        
        if(indexPath.item == 0 ){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 11.0, *) {
                let payVC = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
                 self.navigationController?.pushViewController(payVC, animated: true)
            } else {
                // Fallback on earlier versions
            }
           
        }
        else if(indexPath.item == 3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let slipVC = storyboard.instantiateViewController(withIdentifier: "SlipNumberViewController") as! SlipNumberViewController
            self.navigationController?.pushViewController(slipVC, animated: true)
        } else if (indexPath.item == 2)  {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 11.0, *) {
                let slipVC = storyboard.instantiateViewController(withIdentifier: "AggregationViewController") as! AggregationViewController
                self.navigationController?.pushViewController(slipVC, animated: true)
            } else {
                // Fallback on earlier versions
            }
            
        }
        else if(indexPath.item == 5) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 11.0, *) {
                let activationVC = storyboard.instantiateViewController(withIdentifier: "ActivationStatusViewController") as! ActivationStatusViewController
                 self.navigationController?.pushViewController(activationVC, animated: true)
            } else {
                // Fallback on earlier versions
            }
           
        }
        else if(indexPath.item == 6) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 11.0, *) {
                let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterDeviceViewController") as! RegisterDeviceViewController
                self.navigationController?.pushViewController(registerVC, animated: true)
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 - 10, height: collectionView.bounds.width / 3 + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    
    
    func testCallAGgregateApi() {
       
            let Url = String(format: "http://10.232.35.2:8080/v1/aggregate")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameterDictionary = ["ToTID" : "", "FromDate" : "2019-09-15" ,"ToDate": "", "FromTID" : "0000356000000" ] ////YYYY-MM-DD HH:II
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
                }.resume()
        }
        
    
    
}
