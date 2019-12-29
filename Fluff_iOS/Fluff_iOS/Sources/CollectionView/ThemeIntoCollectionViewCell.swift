//
//  ThemeIntoCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class ThemeIntoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var themeIntoImage: UIImageView!
    @IBOutlet weak var themeIntoSellerLabel: UILabel!
    @IBOutlet weak var themeIntoItemLabel: UILabel!
    @IBOutlet weak var themeIntoPriceLabel: UILabel!
    @IBOutlet weak var themeIntoHeartButton: UIButton!
    
    var like: Bool = false
    
    @IBAction func heartClicked(_ sender: UIButton) {
        if like == false {
            like = true
            themeIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartFilledIc"), for: .normal)
        } else {
            like = false
            themeIntoHeartButton.setBackgroundImage(#imageLiteral(resourceName: "heartEmptyIc"), for: .normal)
        }
    }
        
}
