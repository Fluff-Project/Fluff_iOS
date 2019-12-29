//
//  cartListTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class CartListTableViewCell: UITableViewCell {

    @IBOutlet weak var fluvCheckBox: BEMCheckBox!
    @IBOutlet weak var profileImageView: UIButton!
    @IBOutlet weak var fluvNameLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var cartItemCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fluvNameLabel.bottomAnchor.constraint(equalTo: fluvCheckBox.centerYAnchor).isActive = true
        productCountLabel.topAnchor.constraint(equalTo: fluvCheckBox.centerYAnchor).isActive = true
        profileImageView.makeCornerRounded(radius: profileImageView.frame.width / 2)
        profileImageView.clipsToBounds = true
        fluvCheckBox.boxType = .square
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProfileImageView(_ image: UIImage) {
        self.profileImageView.setBackgroundImage(image, for: .normal)
    }
    
    func setFluvNameLabel(_ name: String) {
        self.fluvNameLabel.text = name
    }
    
    func setProductCountLabel(_ count: Int) {
        self.productCountLabel.text = "\(count)개의 상품"
    }
}
