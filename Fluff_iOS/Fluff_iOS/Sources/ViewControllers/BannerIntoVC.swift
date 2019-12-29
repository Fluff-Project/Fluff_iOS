//
//  BannerIntoVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class BannerIntoVC: UIViewController {
    
    @IBOutlet weak var bannerIntoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerIntoCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
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

extension BannerIntoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bannerIntoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerIntoCollectionViewCell", for: indexPath) as! BannerIntoCollectionViewCell
        bannerIntoCollectionViewCell.bannerIntoImage.image = #imageLiteral(resourceName: "416")
        bannerIntoCollectionViewCell.bannerIntoItemLabel.text = "다홍꽃 주렁주렁 가디건"
        
        bannerIntoCollectionViewCell.bannerIntoPriceLabel.text = "98,000원"
        return bannerIntoCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerHeaderReusableView", for: indexPath) as! BannerHeaderReusableView
            return header
        default:
            assert(false)
        }
    }
    
    
    
    
}
