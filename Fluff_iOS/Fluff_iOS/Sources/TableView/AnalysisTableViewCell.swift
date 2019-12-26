//
//  AnalysisTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AnalysisTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var fluvShopLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var clothtagLabel: UILabel!
    @IBOutlet weak var twoClothtagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setInitialCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setInitialCell() {
        followButton.makeCornerRounded(radius: followButton.frame.width / 5)
        clothtagLabel.layer.borderColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0).cgColor
        clothtagLabel.layer.borderWidth = 1.0
        clothtagLabel.textColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0)
        clothtagLabel.makeCornerRounded(radius: clothtagLabel.frame.width / 5.625)
        twoClothtagLabel.layer.borderColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0).cgColor
        twoClothtagLabel.layer.borderWidth = 1.0
        twoClothtagLabel.textColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0)
        twoClothtagLabel.makeCornerRounded(radius: twoClothtagLabel.frame.width / 5.625)
        
        fluvShopLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        
    }
}
