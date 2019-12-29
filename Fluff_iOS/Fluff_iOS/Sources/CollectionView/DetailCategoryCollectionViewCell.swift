//
//  DetailCategoryCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class DetailCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
//    override var isSelected: Bool {
//        didSet {
//            self.categoryLabel.textColor = isSelected ? UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0) : .white
//            self.layer.borderColor = isSelected ? UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0).cgColor : UIColor.white.cgColor
//        }
//    }
    
    // 나중에 디벨롭할 때 쓰기.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setLabel(_ category: String) {
        self.categoryLabel.text = category
        self.categoryLabel.textColor = .white
    }
    
    func setNotSelected() {
        self.categoryLabel.textColor = .white
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func setSelected() {
        self.categoryLabel.textColor = UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1)
        self.layer.borderColor = UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1).cgColor
    }
}
