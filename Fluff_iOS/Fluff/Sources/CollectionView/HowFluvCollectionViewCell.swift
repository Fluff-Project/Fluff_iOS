//
//  HowFluvCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/27.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class HowFluvCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var howFluvView: UIView!
    @IBOutlet weak var fluvProfileImage: UIImageView!
    @IBOutlet weak var fluvName: UILabel!
    @IBOutlet weak var fluvTag1: UILabel!
    @IBOutlet weak var fluvTag2: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib() {
        self.fluvProfileImage.makeCornerRounded(radius: fluvProfileImage.frame.width / 2)
    }
}
