//
//  AuctionDetailCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AuctionDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var auctionDetailImage: UIImageView!
    
    func setAuctionImage(_ image: UIImage) {
        self.auctionDetailImage.image = image
    }
}
