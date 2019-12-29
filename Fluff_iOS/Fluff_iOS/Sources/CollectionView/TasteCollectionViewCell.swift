//
//  TasteCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class TasteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var clotheImageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var checkboxButton: BEMCheckBox!
    
    func selected(_ isSelected: Bool) {
        if isSelected {
            coverView.isHidden = true
//            checkboxButton.on = false
            checkboxButton.setOn(false, animated: true)
        } else {
            coverView.isHidden = false
//            checkboxButton.on = true
            checkboxButton.setOn(true, animated: true)
        }
    }
    
    func setCoverView() {
        coverView.isHidden = false
        checkboxButton.on = true
    }
    
    func hideCoverView() {
        coverView.isHidden = true
        checkboxButton.on = false
    }
}
