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
    
//    var like: Bool = false
    private var index: Int?
    private var isClicked: Bool?
    
    func setIndex(_ index: Int) {
        self.index = index
    }
    
    func setIsClicked(_ isClicked: Bool) {
        self.isClicked = isClicked
    }
    
    func setHeart(_ isClicked: Bool) {
        if isClicked {
            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartFilledIc"), for: .normal)
        } else {
            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartEmptyIc"), for: .normal)
        }
    }
    
    @IBAction func heartClicked(_ sender: UIButton) {
//        if like == false {
//            like = true
//            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartFilledIc"), for: .normal)
//        } else {
//            like = false
//            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartEmptyIc"), for: .normal)
//        }
//
        
        
        guard let isClicked = self.isClicked else { return }
        
        if isClicked {
            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartEmptyIc"), for: .normal)
        } else {
            bannerIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartFilledIc"), for: .normal)
        }
        guard let index = self.index else { return }
        NotificationCenter.default.post(name: .clickIntoBannerHeartButton, object: nil, userInfo: ["index": index, "isSelected": isClicked])
    }
}
