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
    
    func setClotheImage(_ imageName: UIImage) {
        self.clotheImageView.image = imageName
    }
    
    func setName(_ name: String) {
        clotheNameLabel.text = name
    }
    
    func setPrice(_ price: String) {
        priceLabel.text = price
    }
}
