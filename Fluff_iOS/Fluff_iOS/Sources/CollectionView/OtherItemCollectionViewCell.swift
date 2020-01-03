//
//  OtherItemCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class OtherItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var clotheImageView: UIImageView!
    @IBOutlet weak var clotheNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setClotheImage(_ url: String) {
        print(url)
        self.clotheImageView.setImage(with: url)
    }
    
    func setName(_ name: String) {
        clotheNameLabel.text = name
    }
    
    func setPrice(_ price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattingNumber = (numberFormatter.string(from: NSNumber(value: price)) ?? "0")
        priceLabel.text = formattingNumber
    }
}
