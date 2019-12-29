//
//  BannerIntoCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class BannerIntoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerIntoImage: UIImageView!
    @IBOutlet weak var bannerIntoSellerLabel: UILabel!
    @IBOutlet weak var bannerIntoItemLabel: UILabel!
    @IBOutlet weak var bannerIntoPriceLabel: UILabel!
    @IBOutlet weak var bannerIntoHeartButton: UIButton!
    
    var like: Bool = false
    
    @IBAction func heartClicked(_ sender: UIButton) {
        if like == false {
            like = true
            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartFilledIc"), for: .normal)
        } else {
            like = false
            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartEmptyIc"), for: .normal)
        }
        
    }
}
