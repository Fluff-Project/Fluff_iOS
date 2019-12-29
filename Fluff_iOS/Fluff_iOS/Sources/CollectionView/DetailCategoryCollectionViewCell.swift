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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setLabel(_ category: String) {
        self.categoryLabel.text = category
    }
}
