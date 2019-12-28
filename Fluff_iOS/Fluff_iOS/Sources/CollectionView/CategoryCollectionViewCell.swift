//
//  CategoryCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/28.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setcategoryImage(_ image: UIImage) {
        self.categoryImageView.image = image
    }
    
    func setCategoryLabel(name: String) {
        self.categoryLabel.text = name
    }
    
    func setCategoryLabelColor(_ color: UIColor) {
        categoryLabel.textColor = color
    }

}
