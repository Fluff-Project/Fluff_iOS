//
//  AuctionCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/27.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AuctionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var auctionItemImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var auctionItemLabel: UILabel!
    
    
    func setInit(auctionImage: UIImage, timer: String, currentPrice: String, auctionItemName: String) {
        self.auctionItemImageView.image = auctionImage
        timerLabel.text = timer
        currentPriceLabel.text = currentPrice
        auctionItemLabel.text = auctionItemName
    }
}
