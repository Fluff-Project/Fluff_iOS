//
//  BannerCell.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var bannerLineLabel: UILabel!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var bannerButton: UIButton!
    
    private var index: Int?
    
    override func awakeFromNib() {
        self.bannerButton.makeCornerRounded(radius: 13)
    }
    
    func setIndex(_ index: Int) {
        self.index = index
    }
    
    @IBAction func intoBanner(_ sender: Any) {
        guard let clickedIndex = index else { return }
        NotificationCenter.default.post(name: .clickIntoBannerButton, object: nil, userInfo: ["clickedIndex": clickedIndex])
    }
}


