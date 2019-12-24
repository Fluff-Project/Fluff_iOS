//
//  DetailItemCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class DetailItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var clotheImageView: UIImageView!
    
    func setClotheImage(_ imageName: String) {
        guard let clotheImage = UIImage(named: imageName) else { return }
        clotheImageView.image = clotheImage
    }
}
