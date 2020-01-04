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
    @IBOutlet weak var currentPriceDescriptionLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceUnitLabel: UILabel!
    @IBOutlet weak var auctionItemLabel: UILabel!
    @IBOutlet weak var lestDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        timerLabel.font = UIFont(name: "KoPubWorldDotumPM", size: 17)
        currentPriceDescriptionLabel.font = UIFont(name: "KoPubWorldDotumPB", size: 14)
        currentPriceLabel.font = UIFont(name: "S-CoreDream-7ExtraBold", size: 24)
        priceUnitLabel.font = UIFont(name: "KoPubWorldDotumPB", size: 14)
        timerLabel.font = UIFont(name: "S-CoreDream-7ExtraBold", size: 14)
        lestDescriptionLabel.font = UIFont(name: "KoPubWorldDotumPM", size: 12)
    }
    
    func setImage(_ url: String) {
        self.auctionItemImageView.setImage(with: url)
    }
    
    func setPrice(_ price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattingNumber = (numberFormatter.string(from: NSNumber(value: price)) ?? "0") + "원"
        self.currentPriceLabel.text = formattingNumber
    }
    
    func setNameLabel(_ name: String) {
        self.auctionItemLabel.text = name
    }
    
}
