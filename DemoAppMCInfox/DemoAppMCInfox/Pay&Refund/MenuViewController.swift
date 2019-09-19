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
    
    let menuLblArray = ["Pay","Money","Report","Refund","Wallet"]
    
    let imageArray = ["pay","money","report","refund","wallet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if(indexPath.item == 0 ){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let payVC = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            self.navigationController?.pushViewController(payVC, animated: true)
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
    
    
}
