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
    
    //이승수가 맘대로 코딩한것
//    override var isSelected: Bool {
//        didSet {
//            self.categoryImageView.tintColor = isSelected ? UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0) : .white
//            self.categoryLabel.textColor = isSelected ? UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0) : .white
//        }
//    }
//
//    override var isHighlighted: Bool {
//        didSet {
//            self.categoryImageView.tintColor = isSelected ? UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0) : .white
//            self.categoryLabel.textColor = isSelected ? UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0) : .white
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //이승수가 맘대로 코딩함
//        self.categoryImageView.tintColor = .white
//        self.categoryImageView.image = categoryImageView.image?.withRenderingMode(.alwaysTemplate)
//
//        self.categoryLabel.textColor = .white
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
