//
//  TasteCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class TasteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var clotheImageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    
    func selected(_ isSelected: Bool) {
        if isSelected {
            coverView.isHidden = true
        } else {
            coverView.isHidden = false
        }
    }
    
    func setCoverView() {
        coverView.isHidden = false
    }
    
    func hideCoverView() {
        coverView.isHidden = true
    }
}
